# Study Club — Little Learners

A mobile-first, animated learning web app / installable PWA for Nursery, LKG, UKG and Class 1.

## Included
- Parent sign-in, account creation, sign-out and password reset using Supabase Auth (optional configuration).
- Guest mode for trying the app without an account.
- Four early-learning levels and eight learning areas: phonics, numbers, colours/shapes, animals, first words, nature/science, rhymes/stories and thinking games.
- Alphabet and number learning cards with spoken prompts using device/browser speech synthesis.
- Randomised short quizzes, instant feedback, stars and activity history.
- Finger/mouse letter tracing canvas and short value-based stories.
- Parent area for learner nickname, class and progress.
- Responsive mobile/desktop layout, motion-reduction support, installable PWA shell and basic offline app-shell caching.

## Run without login
Open `index.html` in a browser, or serve this folder over HTTP:
```bash
python -m http.server 8000
```
Visit `http://localhost:8000`. Guest progress is stored in that browser only.

## Enable real parent login and cloud progress
1. Create a Supabase project.
2. In Supabase SQL Editor, run the contents of `supabase/schema.sql`.
3. Open the existing `config.js` and replace the two placeholder values with the Project URL and anon/publishable key from Supabase project settings. (The `config.js.example` file is a reference template.)
4. Configure Supabase Auth email confirmation and your deployed site's redirect URL in Supabase Authentication settings.
5. Deploy over HTTPS.

The browser uses only the public anon/publishable key. Never put a Supabase service-role key in frontend code. Row Level Security in the supplied SQL restricts each parent account to its own progress row.

## Deploy as web + app
Deploy the static repository to GitHub Pages, Netlify or Vercel. A GitHub Pages workflow is included; enable **Settings → Pages → Build and deployment → GitHub Actions** once to allow it to publish. On Android, open the HTTPS site in Chrome and choose **Install app** / **Add to Home screen**. On iPhone, use Safari → Share → Add to Home Screen. Service workers and installation require HTTPS (or localhost).

## Important product notes
- If Supabase is not configured, the sign-in screen explains that online sign-in needs setup; **Explore as guest** remains available.
- Guest progress stays on the device. Signed-in progress can sync to Supabase after the SQL and config steps are completed.
- This is an early-learning starter curriculum, not a guarantee of school rank or exam results. Teachers/parents should review lessons for local syllabus fit and support children's learning.
- Speech playback depends on the device's available voices. The app does not collect a child's name beyond the nickname entered by the parent.
