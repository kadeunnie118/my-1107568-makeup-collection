# My Makeup Collection

A simple web app to keep track of your makeup and tools, so you never buy a duplicate again.

## What it does

- **Add an item**: take a photo or pick one from your gallery, choose a category, type the brand. Product, shade and color are optional.
- **My collection**: a photo grid you can search and filter by category.
- **Do I already have this?**: type what you're about to buy (e.g. "nude lipstick") and see what you already own, plus similar colors.
- **Duplicate warning**: if you add the same brand and shade twice, the app asks before saving.
- **Barcode scanning**: on *Add item*, tap **Scan the barcode** to save it with the item (the app warns you if you already own that exact barcode). On *Do I already have this?*, tap **Scan a barcode** in the shop to check instantly against your own collection. If the camera can't read it, type the numbers under the barcode instead. No outside product database is used.
- **Accounts (optional)**: tap the person button to sign in with your email (we email you a sign-in code, no password). Your items and photos are then saved online and appear on all your devices. You can sign out or delete your account at any time. Signing in isn't required.
- **Backup**: save your collection to a file and restore it later (tap the ••• button on the home screen).

## Important: where your data is saved

If you **don't sign in**, everything is saved **only on the phone or computer you use**, inside the browser.
Clearing the browser's website data will erase it, so use **••• → Save backup file** now and then.

If you **sign in**, your items and photos are also saved online (Supabase) and sync between your devices.
See [privacy.html](privacy.html).

## Accounts setup (Supabase)

The account button only appears once `SUPABASE_URL` and `SUPABASE_KEY` are filled in near the
"Accounts & online saving" section of `index.html`. Setup files are in the `setup/` folder:

- `setup/supabase-setup.sql`: run once in Supabase → SQL Editor (tables, security rules, photo storage, delete-account function)
- `setup/email-template.html`: paste into Supabase → Authentication → Emails (Magic Link and Confirm signup)

Sign-in emails need a custom SMTP sender (we use a Hostinger mailbox), because Supabase's built-in
email only reaches the project's own team.

## How updates go live

The main address is **https://makeup.danitalab.com** (Hostinger).
Hostinger is connected to this repository: every change saved to the `main` branch is copied
to the `public_html/makeup` folder automatically, usually within a minute.
(Hostinger dashboard → Websites → danitalab.com → Advanced → Git.)

## Also online with GitHub Pages

1. In this repository, open **Settings → Pages**.
2. Under **Branch**, choose `main` and the `/ (root)` folder, then click **Save**.
3. After a minute or two, your app is live at
   `https://kadeunnie118.github.io/my-1107568-makeup-collection/`

## Add it to your phone's home screen

- **iPhone (Safari):** open the link, tap **Share → Add to Home Screen**.
- **Android (Chrome):** open the link, tap **⋮ → Add to Home screen**.

## Files

| File | What it is |
|---|---|
| `index.html` | The whole app: screens, styles and code |
| `manifest.webmanifest` | Name, colors and icon used when added to the home screen |
| `icon.svg`, `icon-*.png` | The app icon |
| `privacy.html` | Privacy policy |
| `setup/` | One-time Supabase setup files |

## Ideas for later

1. ~~Barcode scanning~~ (done)
2. A shared product catalog, so items can be matched automatically
3. Reading the brand and shade from the photo
4. Scanning a whole drawer at once
5. ~~Accounts and online saving~~ (done)
