# Study Club — Little Learners

A colourful, animated, mobile-first learning web app and installable PWA for Nursery, LKG, UKG and Class 1.

## Included
- Parent account creation and sign-in without Supabase or any backend.
- Passwords are salted and hashed in the browser using PBKDF2; password recovery uses the parent recovery code created during sign-up.
- Guest mode for trying the app without an account.
- Four early-learning levels and fourteen learning areas: English phonics, numbers and maths, colours and shapes, animals, first words, nature and science, rhymes and stories, brain games, Telugu letters and words, general knowledge, body and health, safety, transport, and everyday maths.
- Spoken prompts, shuffled quizzes with picture and clue-based questions for every class-appropriate lesson, manual Next control, instant feedback, stars and activity history. Questions do not repeat within a round; a fresh shuffled round is available after completion.
- Finger/mouse letter tracing and short value-based stories.
- Parent area for learner nickname, class and progress.
- Animated feedback screen with 1–5 star rating, feedback categories, message form and thank-you state. Feedback is stored locally on the current device only; it is not transmitted to the developers.
- Responsive mobile/desktop layout, reduced-motion support, installable PWA shell and basic offline app-shell caching.

## Parent login and privacy
Parent login is fully device-local. No external authentication service, backend, database, API key or account configuration is needed. Create a parent account from the sign-in screen, use an email address as the local account label, choose a password of at least 8 characters and set a recovery code of at least 6 characters. Keep the recovery code safe.

**Important limitation:** accounts and progress are stored only in the current browser on the current device. They do not sync to other phones or computers, and clearing browser site data can erase them. Password reset works on that same device using the recovery code. This is a device-local profile system, not a hosted identity service or multi-device cloud account. Do not use it for sensitive data.

Guest progress is also stored locally. Use a modern browser over HTTPS for secure password hashing; GitHub Pages provides HTTPS.

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
