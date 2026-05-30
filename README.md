# LMA Class of 2026 Yearbook

A senior yearbook site for the Legacy Magnet Academy graduating class of 2026, built by Milo Madolora during senior year. Static HTML/CSS/JS — no build step, no framework, no backend. Hosted on GitHub Pages at [milomadatu.github.io/lma-class-of-2026](https://milomadatu.github.io/lma-class-of-2026).

## What's inside

- **Landing page**: hero rotation, countdown-turned-celebration panel, upcoming events strip
- **Archive**: 17 carousels of school-year events, sortable by person or group, with a separate favorites gallery (500+ photos)
- **People**: 101 senior cards with surveys, bios, college destinations, and friend-group sheets
- **Stats**: a US/SoCal/Bay Area map of college destinations, college-decision pie charts, a word cloud from survey responses

## Local development

```bash
git clone https://github.com/milomadatu/lma-class-of-2026.git
cd lma-class-of-2026
python -m http.server 8000   # or VS Code Live Server
```

Open `http://localhost:8000`. Hard-refresh (Ctrl+Shift+R) after image swaps to bypass the cache.

That's it. The entire site is `index.html` — a single ~5000-line file containing HTML, CSS, and JS inline. No `package.json`, no node_modules. Edit and reload.

## Project structure

```
index.html               # everything: markup, styles, data, scripts
CLAUDE.md                # detailed conventions doc for AI assistance
README.md                # this file
images/
  Headshots/             # senior portraits: "First L.webp" (e.g. "Milo M.webp")
  YBHeadshots/           # local-only photo backups (not committed)
  favs/                  # favorite photos (PascalCase nickname filenames)
  groups/                # VE company banners & logos
  lfd/                   # Last First Day (Instagram-sourced)
  ss/                    # Senior Sunrise
  inschoolevents/        # In School Events
  mb/                    # Senior Blues (Music + Blues)
  sb/                    # Senior Bonfire
  wf/                    # Winter Formal
  sdd/                   # Senior Ditch Day
  prom/                  # Prom
  sas/                   # Soak a Senior
  dwd/                   # Denim & White Dinner
  skyzone/               # Senior Skyzone
  san/                   # Senior Awards Night
  ld/                    # Last Day of School
  sensun/                # Senior Sunset
```

## Adding content

All data lives in JS arrays near the bottom of `index.html`. No database, no API.

### Add a senior to the People grid
Append to the `people` array (line ~1459). Drop a 1:1 headshot at `images/Headshots/First L.webp` matching the disambiguator convention (`Brandon Ca`, `Brandon Ch` for the two Brandons, etc.). All fields are required even if blank.

### Add a favorite photo
Append to `FAVORITES` (line ~3935). Use the `First L` caption convention so names link via the chip filter. Drop the photo at `images/favs/PascalCaseName.webp`. After adding, run the rebalance:

```powershell
.\measure_all_favs.ps1   # measures dimensions into fav_dims.csv
python rebalance_favs.py # brute-forces best 3-column partition per page
```

These helper scripts are gitignored — they regenerate from current data.

### Add a carousel section
1. Add a chip button in the mobile nav (`<button onclick="scrollToSection('arc-XXX')">`)
2. Add a timeline card in the sidebar
3. Add an entry in `ARCHIVE_SECTIONS` with `id`, `imgFolder`, `images: [{file, post, caption}]`, `posts: []`
4. For Instagram-sourced carousels, use the IG post shortcode as both `file` (e.g. `DYfA0ubOQAz.webp`) and `post`. For non-IG, use `post: ''`.

### Add a university to the map
Append to the `universities` array. Only schools with non-empty `igPosts` count toward the landing "Universities" stat — keep that in mind for partial data.

## Conventions

- **Caption format**: `First L` for students (matching headshot filename). 2 names: `A & B`. 3+ names: `A, B, C & D` (Oxford comma omitted, ampersand before last name). Teachers use `Initial Lastname` (e.g. `T Isaacs`, `D Licciardo`).
- **Senior nicknames**: match the headshot file, not the spoken name. If the file is `Christopher C.webp`, caption as `Christopher C` even if everyone calls him Chris.
- **Event tags**: case-sensitive, see `CLAUDE.md` for the full list.
- **Survey updates**: when a senior fills out a new survey, update the landing stats, pie charts, word cloud, and their card in one pass. Word-cloud descriptors enter at `value: 10` for new ones, +1 to existing.
- **Code style**: no comments unless the *why* is non-obvious; no documentation comments; terse identifiers.

## For the class of 2027 (and beyond)

If you're a junior reading this and want to fork the site for next year:

1. Fork the repo on GitHub
2. Enable GitHub Pages in repo settings → Pages → Source: `master` branch
3. Replace `images/Headshots/` with your class
4. Rewrite the `people` array (line ~1459)
5. Update meta tags at the top of `index.html` (title, OG image, descriptions)
6. Wipe `ARCHIVE_SECTIONS` and `FAVORITES` and rebuild as your year progresses
7. Update the countdown target date in the JS (`const target = new Date(...)`) and flip the Graduated panel back to a live timer for your grad day
8. The unused `.countdown-units`, `.countdown-num`, `.countdown-progress-*` CSS is intentionally preserved for you to reuse

The site doesn't require a backend, account system, or paid hosting — GitHub Pages is free and works fine for a class-sized audience.

## Performance & privacy

- No analytics, no tracking, no cookies, no personal data collection
- Lazy-loaded images, lazy-rendered page bodies (People + Archive build on first visit)
- Instagram embeds load on demand via `processEmbeds()`
- Static GitHub Pages hosting has a cache-lifetime ceiling that can't be tuned — DOM size and image compression are the real performance levers

## Removing your photo

If you appear on the site and want your photo or content removed, email **milomadatu@gmail.com** and I'll take it down. No questions, no friction.

## Credits

Site, code, and curation by Milo Madolora. Photos from the class, the school's `legacydecisions.26` Instagram, and friends who shared their cameras. Thanks to everyone who filled out a survey, sent a picture, or let me document the year.

— *Class of 2026 · May 29, 2026*
