# Study Club — Little Learners

A colourful, animated, mobile-first learning playground for **Nursery, LKG, UKG and Class 1**.

## Included in this starter release
- Class selection for four early-learning levels
- Eight learning areas: letters & phonics, numbers & maths, colours & shapes, animals, first words, nature, rhymes & stories, and brain games
- Tap-to-learn cards with optional spoken prompts using the browser's speech synthesis
- Quick quizzes with instant feedback and star rewards
- Learner nickname, activity history and progress saved in the browser
- Responsive layouts, motion-reduction support, and an installable/offline app shell (PWA)

## Run locally
Open `index.html` in a browser, or serve the folder over HTTP:

```bash
python -m http.server 8000
```

Then visit `http://localhost:8000`.

## Deploy
The app is static and has no required backend or secret keys. It can be deployed to GitHub Pages, Netlify or Vercel. For service-worker/offline and install support, open it over HTTPS (or localhost).

## Notes
- Progress is stored locally in the current browser using localStorage; it does not sync between devices.
- Speech playback depends on browser/device speech support and may use installed system voices.
- The first release intentionally avoids collecting children's personal information or requiring accounts.
