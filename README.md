# My Makeup Collection

A simple web app to keep track of your makeup and tools, so you never buy a duplicate again.

## What it does (version 1)

- **Add an item**: take a photo, choose a category, type the brand. Product, shade and color are optional.
- **My collection**: a photo grid you can search and filter by category.
- **Do I already have this?**: type what you're about to buy (e.g. "nude lipstick") and see what you already own, plus similar colors.
- **Duplicate warning**: if you add the same brand and shade twice, the app asks before saving.
- **Backup**: save your collection to a file and restore it later (tap the ••• button on the home screen).

## Important: where your data is saved

Everything is saved **only on the phone or computer you use**, inside the browser.
It does not sync between devices, and clearing the browser's website data will erase it.
Use **••• → Save backup file** now and then.

## Put it online with GitHub Pages

1. In this repository, open **Settings → Pages**.
2. Under **Branch**, choose `main` and the `/ (root)` folder, then click **Save**.
3. After a minute or two, your app is live at
   `https://danita-tho.github.io/my-1107568-makeup-collection/`

## Add it to your phone's home screen

- **iPhone (Safari):** open the link, tap **Share → Add to Home Screen**.
- **Android (Chrome):** open the link, tap **⋮ → Add to Home screen**.

## Files

| File | What it is |
|---|---|
| `index.html` | The whole app: screens, styles and code |
| `manifest.webmanifest` | Name, colors and icon used when added to the home screen |
| `icon.svg`, `icon-*.png` | The app icon |

## Ideas for later

1. Barcode scanning
2. A shared product catalog, so items can be matched automatically
3. Reading the brand and shade from the photo
4. Scanning a whole drawer at once
5. Accounts and online saving, so friends can have their own collections
