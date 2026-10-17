# Foxnet404 — GitHub Pages deployment

**Motto:** “Stealthy foxes hunt in the digital shadows.”

This is a static website built with HTML, CSS, and JavaScript. It has no build step or package manager.

## Files

- `index.html` — homepage and responsive styling
- `404.html` — custom branded not-found page
- `.nojekyll` — prevents default Jekyll processing

## Enable GitHub Pages

1. Open **Settings → Pages** in this repository.
2. Under **Build and deployment**, choose **Deploy from a branch**.
3. Select branch **main** and folder **/(root)**, then click **Save**.
4. Wait for the deployment workflow to finish. GitHub will show the live address in Settings → Pages.

The expected project-site URL is:

`https://samuelgetson15.github.io/Foxnet404-Web/`

The repository is currently private. GitHub Pages availability for a private repository depends on your GitHub plan; on GitHub Free, make the repository public to publish Pages at no cost. **Changing a repository to public exposes its source files and commit history**, so do this only after reviewing the contents and deciding that they can be public.

## Contact form

The enquiry form now includes client-side validation, a consent checkbox, a honeypot field and a Supabase REST submission flow. It is not live until you create the separate Supabase project, run the SQL schema and replace the placeholders in `supabase-config.js`.

## Before launch

- Review service descriptions and company claims for accuracy.
- Do not imply certifications, clients, or 24/7 monitoring unless they are real.
- Do not commit passwords, API keys, customer data, or other secrets.
- The site imports Google Fonts externally; fallback system fonts are defined.


## Contact form database (Supabase)

The contact form now submits enquiries to a **separate Supabase project** when configured. GitHub Pages serves only the front end, so it cannot host a database itself.

### 1. Create the separate database

1. Create a Supabase account and a new project dedicated to these enquiries (suggested project name: `Foxnet404-Contacts`).
2. Open the new project's **SQL Editor**.
3. Run all of `supabase/schema.sql`.
4. In the Supabase project settings/API section, copy the **Project URL** and the **publishable key** (older projects may label this the anon key).

### 2. Connect the website

1. Edit `supabase-config.js` in this GitHub repository.
2. Replace `https://YOUR-PROJECT-REF.supabase.co` with the project URL and `YOUR-PUBLISHABLE-KEY` with the publishable key.
3. Commit the change. The key is intentionally browser-visible and is **not a secret**; never put a Supabase secret or `service_role` key in this file.
4. Submit a test enquiry on the deployed site, then confirm a new row appears under **Table Editor → contact_submissions** in Supabase.

### Security model and limitations

- Row Level Security is enabled.
- Public visitors receive INSERT permission only. Public SELECT, UPDATE, and DELETE are not granted.
- Administrators can review enquiries in the Supabase dashboard.
- The schema validates names, email shape, service choices, message length and consent.
- This public form is still susceptible to spam/automated submissions. Before promoting it widely, add a CAPTCHA/rate-limit control (ideally enforced with a Supabase Edge Function) and publish a privacy notice describing purpose, access and retention.
- Do not ask visitors for passwords, API keys or other secrets through this form.

Until `supabase-config.js` is connected to a real project and the SQL is run, the form will display a clear not-configured message and will not pretend an enquiry was saved.
