# Study Club — Supabase setup

Study Club is deployed as a static web app on Vercel (with GitHub Pages retained as an alternate deployment). Supabase provides parent authentication, cloud learner progress, and owner-only feedback administration. The browser uses only the project's publishable key; Row Level Security (RLS) protects the data.

## Project

- Supabase project URL: `https://wozvcabjepdjkcuasqko.supabase.co`
- Primary live URL: `https://study-club-lemon.vercel.app/`
- Alternate GitHub Pages URL: `https://narsing-s.github.io/Study-club/`
- Owner/admin email: `narsingbeesetti22@gmail.com`

## 1. Apply the database migration

In the Supabase dashboard for the project above, open **SQL Editor** and run the complete file:

`supabase/migrations/20261107000100_cloud_accounts_progress_feedback.sql`

This creates:
- `parent_profiles`: one parent identity per Supabase Auth user
- `learner_profiles`: learner records owned by a parent
- `learning_progress`: cloud progress tied to the learner and parent
- `study_club_feedback`: feedback submitted by signed-in parents

RLS is enabled. Parents can manage only their own learner and progress records. Only the verified owner identity can read, review, or delete feedback. Do not disable RLS.

**Important:** committing the migration to GitHub does not run it in Supabase. It must be applied once in the SQL Editor.

## 2. Configure Auth redirect URLs

In **Authentication → URL Configuration** set:

- Site URL: `https://study-club-lemon.vercel.app/`
- Additional Redirect URL: `https://study-club-lemon.vercel.app/**`
- Optional alternate redirect: `https://narsing-s.github.io/Study-club/**`

Save the settings. New sign-up confirmation emails explicitly redirect to the Vercel live URL. Add that URL to Supabase's allow-list before testing confirmation links. If a confirmation email was generated before this redirect fix, request a fresh one from the app.

## 3. Configure owner admin

Create the Supabase Auth user `narsingbeesetti22@gmail.com` in **Authentication → Users → Add user → Create new user**. Set a strong password that you keep private, and use the dashboard's **Auto Confirm User** option for this owner account only (or confirm it through the normal email flow after SMTP is working). This avoids depending on the currently blocked test-email sender for the site owner; it does not turn off email confirmation for other users. Then use that same email and password in **Admin login**. The owner check is enforced by `public.is_study_club_owner()` and requires the exact email to be confirmed; changing the email typed in the browser cannot grant admin access. If the owner user already exists, do not create a duplicate—check its confirmation status and reset/set its password from the dashboard.

## 4. Configure email delivery for multiple users

Supabase's built-in test email service is not suitable for public sign-ups: it currently sends only to addresses belonging to the project's organization team and is limited to 2 emails per hour across the entire project. The limit is shared by all users, so it can block registrations for everyone even when each person uses a different email address.

For a public or multi-user app, configure a real SMTP provider:

1. Choose an SMTP email provider and verify the sender identity/domain required by that provider.
2. In Supabase, open **Project Settings → Authentication → SMTP Settings** (or **Authentication → SMTP Settings**, depending on dashboard layout).
3. Enable custom SMTP and enter the provider's SMTP host, port, username, password, and verified sender address.
4. Save and test with a small number of sign-ups.
5. Review **Authentication → Rate Limits**. Supabase's initial email limit with custom SMTP is 30 emails per hour and can be adjusted there; the SMTP provider's own quota and sending policies still apply.

Do not paste SMTP credentials into this repository, HTML, JavaScript, or chat. Add them only in the Supabase dashboard. Do not disable email confirmation to work around rate limits.

Dashboard shortcuts:
- [Auth URL Configuration](https://supabase.com/dashboard/project/wozvcabjepdjkcuasqko/auth/url-configuration)
- [SMTP Settings](https://supabase.com/dashboard/project/wozvcabjepdjkcuasqko/auth/smtp)
- [Auth Rate Limits](https://supabase.com/dashboard/project/wozvcabjepdjkcuasqko/auth/rate-limits)
- [Auth Users](https://supabase.com/dashboard/project/wozvcabjepdjkcuasqko/auth/users)

## 5. Multi-user data and local progress

Each signed-in parent is identified by the Supabase Auth user ID. Learners and progress are stored against that ID and checked by RLS. The app also keeps a per-email local cache for that parent's progress. Guest progress is stored separately on the device.

The app no longer imports the browser's old shared progress key into a newly signed-in account or guest session. This prevents one parent's legacy local progress from appearing in another parent's account on a shared device. The old key is left untouched in browser storage; it is not deleted, but it is not automatically assigned to any account.

The currently visible class selector contains Nursery, LKG, UKG, and Class 1. The database accepts additional class labels for future expansion, but that does not mean those classes are currently available in the app UI.

## 6. Keys and security

- The project URL and publishable key in the client are intended for browser use when RLS is correctly enabled.
- Never put a Supabase secret key or service-role key in GitHub Pages, HTML, JavaScript, or chat.
- Keep email confirmation enabled.
- Never grant admin privileges based only on a client-side email field.
