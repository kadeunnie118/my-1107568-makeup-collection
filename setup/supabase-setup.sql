-- =====================================================================
-- My Makeup Collection: Supabase setup
-- Paste ALL of this into Supabase → SQL Editor → New query, then click Run.
-- It is safe to run again later (it won't duplicate anything).
-- =====================================================================


-- 1) The table that holds everyone's makeup items ----------------------
create table if not exists public.items (
  user_id     uuid    not null default auth.uid() references auth.users (id) on delete cascade,
  id          text    not null,
  category    text    not null default 'Other',
  brand       text    not null default '',
  product     text    not null default '',
  shade       text    not null default '',
  color       text    not null default '',
  notes       text    not null default '',
  barcode     text    not null default '',
  photo_path  text    not null default '',
  created_at  bigint  not null default 0,
  updated_at  bigint  not null default 0,
  deleted     boolean not null default false,
  primary key (user_id, id),
  constraint items_sizes check (
    char_length(id) <= 64 and char_length(category) <= 20 and char_length(brand) <= 200 and
    char_length(product) <= 200 and char_length(shade) <= 200 and char_length(color) <= 7 and
    char_length(notes) <= 2000 and char_length(barcode) <= 64 and char_length(photo_path) <= 300
  )
);

grant select, insert, update, delete on public.items to authenticated;

-- Row level security: each person can only ever see and change their OWN items.
alter table public.items enable row level security;

drop policy if exists "Read own items"   on public.items;
drop policy if exists "Add own items"    on public.items;
drop policy if exists "Change own items" on public.items;
drop policy if exists "Remove own items" on public.items;

create policy "Read own items"   on public.items for select to authenticated
  using ((select auth.uid()) = user_id);
create policy "Add own items"    on public.items for insert to authenticated
  with check ((select auth.uid()) = user_id);
create policy "Change own items" on public.items for update to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "Remove own items" on public.items for delete to authenticated
  using ((select auth.uid()) = user_id);


-- 2) Private photo storage ---------------------------------------------
-- Each person's photos go in a folder named after their user id. Max 2 MB per photo.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('photos', 'photos', false, 2097152, array['image/jpeg', 'image/png', 'image/webp'])
on conflict (id) do nothing;

drop policy if exists "Read own photos"   on storage.objects;
drop policy if exists "Add own photos"    on storage.objects;
drop policy if exists "Change own photos" on storage.objects;
drop policy if exists "Remove own photos" on storage.objects;

create policy "Read own photos" on storage.objects for select to authenticated
  using (bucket_id = 'photos' and (storage.foldername(name))[1] = (select auth.uid())::text);
create policy "Add own photos" on storage.objects for insert to authenticated
  with check (bucket_id = 'photos' and (storage.foldername(name))[1] = (select auth.uid())::text);
create policy "Change own photos" on storage.objects for update to authenticated
  using (bucket_id = 'photos' and (storage.foldername(name))[1] = (select auth.uid())::text);
create policy "Remove own photos" on storage.objects for delete to authenticated
  using (bucket_id = 'photos' and (storage.foldername(name))[1] = (select auth.uid())::text);


-- 3) "Delete my account" ------------------------------------------------
-- The app first removes the person's photos, then calls this.
-- Deleting the user also deletes all their items (on delete cascade above).
create or replace function public.delete_my_account()
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  if auth.uid() is null then
    raise exception 'Not signed in';
  end if;
  delete from auth.users where id = auth.uid();
end;
$$;

revoke all on function public.delete_my_account() from public, anon;
grant execute on function public.delete_my_account() to authenticated;
