# Study Club cloud setup

This repository is a static GitHub Pages app. The cloud migration below creates a secure Supabase data layer, but it does not activate cloud sync until the project URL and publishable key are configured in the app integration.

## 1. Create a Supabase project
1. Create a free Supabase project.
2. Keep email confirmation enabled in Authentication settings.
3. In Authentication > Providers > Email, use email/password sign-in.
4. In Project Settings > API Keys, copy the Project URL and the **publishable** key (or legacy anon key).

## 2. Apply the database migration
Open SQL Editor in the Supabase dashboard and run the complete file:
`supabase/migrations/20261107000100_cloud_accounts_progress_feedback.sql`

The migration creates parent profiles, learner profiles, JSON progress storage, and feedback storage. Row Level Security is enabled on every table. Parents can access only their own learners and progress. Feedback is visible, editable and deletable only by the owner identity.

## 3. Configure the owner account
Create/sign up the Supabase Auth user using **narsingbeesetti22@gmail.com**, complete email confirmation, and then use that account for the owner admin sign-in. Other accounts do not satisfy the owner policy.

## 4. Keys and safety
- The Project URL and publishable/anon key are designed for browser use when RLS is enabled.
- Never put a Supabase secret key or service-role key in HTML, JavaScript, GitHub Pages, or chat.
- Do not disable RLS.
- Do not treat a browser-only password check as administrator security.

## Current activation status
The migration is the backend foundation only. The current Study Club login, progress and feedback screens still use the existing local-browser storage until the cloud client is configured and connected. Existing local accounts and data are not migrated or overwritten by applying this SQL. Cloud sync should be enabled only after the app has been wired to the project URL and publishable key and tested with separate parent and owner accounts.
