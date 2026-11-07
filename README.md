# Study Club — Little Learners

A colourful, animated, mobile-first learning web app and installable PWA for Nursery, LKG, UKG and Class 1.

## Included
- Parent account creation and sign-in through Supabase Auth, plus a guest mode for trying the app.
- Passwords are salted and hashed in the browser using PBKDF2; password recovery uses the parent recovery code created during sign-up.
- Guest mode for trying the app without an account.
- Four early-learning levels and fourteen learning areas: English phonics, numbers and maths, colours and shapes, animals, first words, nature and science, rhymes and stories, brain games, Telugu letters and words, general knowledge, body and health, safety, transport, and everyday maths.
- Spoken prompts, shuffled quizzes with picture and clue-based questions for every class-appropriate lesson, automatic next-question progression with a manual Next option, instant feedback, end-of-quiz score and percentage, missed-answer review, stars and activity history. Questions do not repeat within a round; a fresh shuffled round is available after completion.
- Searchable subject catalogue, animated screen/card transitions, install-app prompt when supported by the browser, and a learner-friendly quiz flow that advances after feedback, with an optional early Next button.
- Lesson completion tracking with one-time stars, finger/mouse letter tracing and short value-based stories.
- Parent area for learner nickname, class and progress.
- Animated feedback screen with 1–5 star rating, feedback categories, message form and thank-you state. Signed-in feedback is sent to the protected Supabase feedback inbox.
- Responsive mobile/desktop layout, reduced-motion support, installable PWA shell and basic offline app-shell caching.

## Parent login and privacy
- Parent sign-up and sign-in use Supabase Auth when the configured Supabase client is available.
- Guest mode remains available and stores guest progress on the current device.
- Signed-in parent progress and learner profiles sync through Supabase tables protected by Row Level Security (RLS).
- The browser uses only the Supabase publishable key. Never place a service-role or secret key in this repository.
- Email confirmation depends on the configured Supabase Auth redirect allow-list and SMTP provider. Public multi-user sign-up requires custom SMTP; the built-in test sender is rate-limited.
- Local browser caches are retained to make the app responsive, but cloud data is the shared account source of truth.

## Owner administration
- Admin sign-in uses the verified Supabase Auth owner identity `narsingbeesetti006@gmail.com`.
- The owner email is checked both in the app and by the database function `public.is_study_club_owner()`; client-side email text alone cannot grant access.
- Apply both SQL migrations in order from [supabase/SETUP.md](supabase/SETUP.md). The second migration updates the owner allow-list.
- The admin dashboard reads feedback submitted by signed-in parents across devices. The owner account must exist in Supabase Auth, have a password, and be confirmed.
- If the owner account does not exist yet, create it once in Supabase Authentication → Users. Do not create duplicate accounts or share the password.

## Run locally
Serve the repository folder:
```bash
python -m http.server 8000
```
Visit `http://localhost:8000`.

## Deploy as web + app
A GitHub Pages workflow is included. Enable **Settings → Pages → Build and deployment → GitHub Actions** if it is not already enabled. On Android, open the HTTPS site in Chrome and choose **Install app** / **Add to Home screen**. On iPhone, use Safari → Share → Add to Home Screen.

## Learning note
The current curriculum is an expandable early-learning foundation for Nursery through Class 1, not a complete official syllabus or a guarantee of exam results. Content is organised by class level and includes a mix of language, numeracy, discovery, safety and reasoning topics. A parent or teacher should review content and guide the child. Speech playback depends on the device's available voices.


## New learning features
- Class-based Brain Challenge rounds with mixed reasoning, maths, science and everyday-knowledge questions.
- Personal-best quiz percentages saved locally for each class and subject.

- Expanded the mixed Brain Challenge bank for all four current class levels, with additional arithmetic, nature, science, language and everyday-reasoning questions.
- Added a replayable spoken quiz prompt button so learners can hear a question again before choosing an answer.


## Expanded 40,000-question practice bank
- Each currently supported class (Nursery, LKG, UKG and Class 1) has a 10,000-question Brain Challenge bank.
- The bank combines the existing hand-written questions with distinct, age-level question variations generated from number ranges, objects and arithmetic/story contexts. Question wording and answer combinations are varied; this is a practice bank, not a claim of official syllabus coverage.
- Learners can choose 10, 20, 50, 100 or all 10,000 questions for a round. Questions are shuffled, and the selected round size is preserved when replaying.
- The existing quick quizzes, lessons, profiles, progress, stars, stories, tracing and local account features remain in place.


## 40,000-question Brain Challenge update
- Expanded the current four supported classes to 10,000 unique generated Brain Challenge prompts each (40,000 total).
- Nursery focuses on counting and number order; LKG adds early addition and subtraction; UKG adds arithmetic and pair/group counting; Class 1 adds addition, subtraction, multiplication and division word problems.
- Added practice-round sizes of 10, 20, 50, 100, 250, 500, 1,000, 5,000 and 10,000 questions.
- Added more motion polish across the hero, cards, buttons and answer choices, while respecting the device's reduced-motion accessibility preference.
- Cached answer-choice sets for challenge mode so long rounds avoid rebuilding the full answer list on every question.
- The questions are procedurally varied practice prompts, not 40,000 individually authored or officially syllabus-verified items. The supported class list remains Nursery, LKG, UKG and Class 1.


## Admin dashboard and cloud feedback
- Feedback from authenticated parents is stored in Supabase and protected by RLS.
- The owner dashboard includes total/new feedback counts, average rating, filters, review status, deletion and CSV export.
- Owner-level access is verified by the Supabase database policy, not by a browser-local password record.

## Daily challenge and learning insights
- Added an optional 10-question Daily Brain Challenge using the existing challenge quiz flow; it marks as completed for the current local calendar day after the round is finished.
- Added a local learning insights view with study streak, quiz accuracy, activity totals, a seven-day activity chart and a suggested subject to practise based on quiz history.
- These additions reuse existing learner progress records and do not change login, lesson, quiz progression, feedback or account storage formats. No cloud sync is implied.


## Cloud backend foundation (Supabase)
- `supabase/migrations/20261107000100_cloud_accounts_progress_feedback.sql` creates parent profiles, learner profiles, learning progress and feedback tables with RLS.
- `supabase/migrations/20261107000200_update_study_club_owner_email.sql` updates the verified owner allow-list to `narsingbeesetti006@gmail.com`.
- Both migrations must be run manually in the Supabase SQL Editor; committing SQL files to GitHub does not execute them.
- Auth confirmation redirects to the Vercel app at `https://study-club-lemon.vercel.app/`. Add this URL to Supabase Authentication → URL Configuration.
- Setup, SMTP, redirects and security instructions are in [supabase/SETUP.md](supabase/SETUP.md).

## Voice learning and mini-game playground
- English A–Z phonics with spoken example words.
- Telugu vowels and consonants with device-supported Telugu speech.
- Number infinity mode for exploring consecutive numbers from a chosen starting point.
- Three new mini-games: memory matching, shape hunt and colour mixing lab.
- Mini-game rewards add three stars per game once per local calendar day and are saved with learner progress.
- Existing class selection, subjects, lessons, quiz progression, 40,000-question practice bank, stories, tracing, daily challenge and progress views remain available.

