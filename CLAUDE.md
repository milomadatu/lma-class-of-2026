# LMA Class of 2026 Site

Static senior-yearbook site. Single-file architecture: `index.html` is monolithic (HTML, CSS, JS all inline, ~3700 lines). No build step, no package.json. Hosted on GitHub at `milomadatu/lma-class-of-2026`, branch `master`.

## Git Commit Rules

- Never commit folders/files unless explicitly requested (e.g., YBHeadshots, backup folders)
- Only commit when user explicitly asks; do not auto-commit during multi-step tasks
- Wait for user confirmation that assets (photos, headshots) are uploaded before committing

## Scope Discipline

- Only modify what the user explicitly requested. Do not add bannerPos, fields, or items to groups/entries that weren't mentioned
- When user provides image URLs, use them directly — do not WebSearch for alternatives
- When interpreting photo captions or notes, do not assume they are new data entries (groups, favorites) without confirming

## Destructive Operation Safety

- Never delete original files or backup folders during batch operations (cropping, renaming) until the user confirms results are acceptable
- For image processing scripts, default to a non-destructive workflow: write to a new folder, keep originals intact

## Asset folders

- `images/Headshots/` — one webp per senior, filename pattern `First L.webp` (e.g. `Milo M.webp`, `Brandon Ca.webp`, `Marie D.webp`). Disambiguator letter when first-letter collisions exist (Brandon Ca/Ch, Matt C, Marie D for Demuro).
- `images/favs/` — gallery photos. Filename = PascalCase nickname (e.g. `RickysBirthday.webp`, `NowAFunnyOne.webp`).
- `images/groups/` — VE company banners and logos.
- `images/sas/` — Soak a Senior carousel images.

## Key data structures (line numbers approximate)

| Array/object | Purpose | Approx line |
|---|---|---|
| `people` | Senior cards (101) | 1299 |
| `GROUPS` | Friend groups | 1803 |
| `VE_COMPANIES` | VE business cards (Siply/TrueVue/Sunmoon/Setta/Legacy) | 1884 |
| `SURVEY_DATA` | Word cloud + pie charts (single source of truth) | 1958 |
| `universities` | Map pins + IG embeds | 2098 |
| `FAVORITES` | Gallery photos + captions | 3148 |
| `PLACEHOLDER_QUOTE` | Sentinel for cards without surveys | 1585 |

`FAV_PER_PAGE = 12`. Desktop 3-col, mobile 2-col round-robin (col0=0,3,6,9 / col1=1,4,7,10 / col2=2,5,8,11).

Landing stats at lines ~921–923: Seniors / Universities / States. (See Universities Counting Rule below.)

## Caption conventions

- Names: `First L` abbreviation matching headshot file (e.g. `Milo M`, `Brandon Ca`, `Marie D`, `Matt C` not `Matthew C`).
- 2-name caption: `'A & B'`. 3+: `'A, B, C & D'` (Oxford comma omitted, ampersand before the last name).
- Empty event: `event: ''`.
- The smart fav-group matcher silently skips names not in the `people` array — non-class names like `Zane N`, `Nolan E`, `Julian A`, `Hudson G`, `Shriyes C`, `Mukhtaj S`, `Josh T` are valid in captions but won't link.
- Teachers may appear in captions using `Initial Lastname` form (e.g. `T Chase`, `R Tanara` in `MuradTripleT`). Preserve verbatim — they intentionally don't follow the `First L` student convention and won't link to a card.

## Event tag conventions (case-sensitive, used in FAVORITES)

`In the Lab`, `Pie a Senior`, `Halloween`, `HS Volleyball`, `HS Water Polo`, `Senior Assassin`, `Flour Baby`, `VE Warriors`, `Soak a Senior`, `Winter Formal`, `Prom`, `Pep Rally`, `Trunk or Treat`, `Karaoke`, `Tustin Tiller Days`, `Tustin Soccer`, `Los Alamos`, `Senior Sunrise`, `Senior Blues`, `Senior Trip`, `Field Trip`, `New York`, `Bakersfield`, `PJ Day`, `Twin Day`, `BJ's Restaurant`, `FBLA`, `Friday Night Lights`, `Ricky's Birthday`, `Filipino Club Bonfire`, `SoFi Stadium`, `Shot by Jayden C`, `White Lies`, `Robotics`, `Not in the Class of 2026`.

## Carousel captions (timeline)

`ARCHIVE_SECTIONS` (line ~2784) holds the timeline carousel data. Image entries can carry a `caption` field (`First L` names, same convention as FAVORITES). Captions render only inside the `arc-lightbox` popup — no hover overlay on slides. Slides without `caption` (e.g. video reels) are excluded from the timeline chip filter and stay clickable.

## Group banners

`.ve-card-banner { height: 170px; background-size: cover }`. Each `GROUPS` entry can override default centering with `bannerPos: 'X% Y%'` — X is horizontal (0%=left), Y is vertical (0%=top). Decrease Y to show more of image's top (heads); increase to show bottom.

## Working with the codebase

- Edit `index.html` directly with `Edit` tool. The file is large but greppable.
- Test locally with `python -m http.server 8000` from project root, or VS Code Live Server. Hard-refresh (Ctrl+Shift+R) to bypass image cache after banner edits.
- Confirm before committing — user explicitly requests "commit and push" when ready. Don't auto-push.

## Project Conventions

### Universities Counting Rule

- Only count universities that have embeds (non-empty `igPosts`) when displaying the universities count on the landing stats (lines ~921–923)

## Persona note

User is the site owner (Milo Madolora, senior at LMA). Treat this as a personal yearbook project — preserve quotes/captions verbatim from surveys (including typos) unless explicitly asked to fix. Default to terse code style with no comments.
