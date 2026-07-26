# Chicken Ledger — setup

## What it tracks
Each customer has a running balance:
- **Sale** (default K65, editable) adds to what they owe.
- **Payment** (any amount) subtracts from what they owe.
- If a payment is more than what's owed, the balance goes negative — shown as **credit** toward their next chicken. So "change kept as part payment" just works automatically: e.g. record a K65 sale, then a K70 payment, and they'll show K5 credit.
- Full credit purchase: record the sale, leave payment for later — balance shows what they owe.
- Half payment: record the sale (K65), then a payment of whatever they hand over (e.g. K30) — balance shows K35 owed.

## One-time setup (15 min)
1. Go to supabase.com, sign in, create a new free project (pick any name/region/password — save the password somewhere).
2. In the project, go to **SQL Editor > New query**, paste in everything from `schema.sql`, and run it. This creates the two tables.
3. Go to **Project Settings > API**. Copy the **Project URL** and the **anon public** key.
4. Open `index.html` in a text editor, find this section near the top of the `<script>`:
   ```
   const SUPABASE_URL = 'YOUR_SUPABASE_URL';
   const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
   ```
   Paste your URL and key in there.
5. Deploy the whole folder (`index.html`, `manifest.json`, `sw.js`, `icon-192.png`, `icon-512.png`) to GitHub Pages, same as your other apps.
6. Open the GitHub Pages link on each phone that needs it, and "Add to Home Screen" — it installs like a normal app and works offline. When a phone gets signal again it syncs automatically (you'll see "synced" at the top; "X pending" means it's waiting to send).

## How offline sync works
Every sale and payment is saved to the phone immediately, so nothing is lost without signal. When the phone reconnects, it quietly pushes anything new up to Supabase and pulls down anything added from other phones. If two people are offline at once and both add data, both sets of entries are kept — nothing overwrites silently.

## Notes
- The Supabase anon key in the file is not a secret in the usual sense, but it does let anyone who has it read/write the ledger — fine for a small family app, just don't post the GitHub Pages link publicly. Say the word if you'd like a simple PIN/login added later.
- Icons are placeholders (gold "K" mark) — happy to swap in a proper logo if you have one.
