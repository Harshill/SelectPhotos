# The Digital Darkroom — SelectPhotos

A local-first photo culling app for selecting the best ~25 photos from a large shoot (~300 images). Built for photographers who need to narrow down a session before sending selects to an editor.

## Problem

After a photoshoot you have ~300 raw photos. You need to pick the top 25 to send for editing. Currently this means tedious back-and-forth in Lightroom or Finder. This app gives you a purpose-built workflow: browse, compare similar shots, and finalize your selects.

## Scope

- Single project at a time (one photo directory)
- No image upload — reads directly from a local folder
- No EXIF extraction for now (data model should leave room for it later)
- No performance optimization yet — serve full images directly, no thumbnail generation
- Local-only, single user

## Core Workflow

### Phase 1: Selection (Gallery View)
Browse all ~300 photos in a grid. Click a photo to **select** it as a candidate. This is the rough cut.

### Phase 2: Alternate Grouping
This is the key interaction for comparing similar shots:

- **Entering alternate mode:** After selecting a photo (the "primary"), the user toggles into alternate selection mode. Any subsequent clicks mark photos as **alternates** of that primary. Toggle off to return to normal selection.
- **What alternates mean:** Alternates are "contenders for the same slot." Out of a primary + its alternates, only one will make the final cut.
- **Swapping:** In the comparison view, the user can promote an alternate to primary. When this happens, the old primary becomes an alternate — the group stays intact, just the lead changes.
- **Exclusivity:** A photo marked as an alternate is no longer eligible as a standalone selection. It can only make the final cut by being swapped to primary within its group.
- **Late additions:** User should be able to add an alternate to an existing group later (e.g. they find a similar shot 100 photos later and want to attach it to an earlier primary).
- **Future: smart grouping** — Eventually, auto-suggest alternates based on photo similarity (timestamp proximity, visual similarity, filename patterns). For now, fully manual.

### Phase 3: Comparison (Review Groups)
For each primary-with-alternates group, show the primary large with alternates in a sidebar. User can:
- Swap an alternate to primary
- Confirm the primary as the final pick for that group
- Reject alternates

### Phase 4: Tournament (Manual)
If the user still has more than 25 selects after comparison, they manually trigger tournament mode — bracket-style head-to-head elimination until exactly 25 remain.

### Phase 5: Export
Review the final 25 selections. Export filenames as a list/file to hand off to the editor.

## Tech Stack

- **Backend:** Elixir / Phoenix
- **Database:** SQLite (stored alongside the photos in the project directory)
- **Frontend:** Phoenix LiveView + Tailwind CSS, with JavaScript hooks for interactive UI (zoom, drag, keyboard shortcuts)
- **Design system:** See [DESIGN.md](DESIGN.md) — dark, minimal "digital darkroom" aesthetic. Reference HTML mockups in [frontend_examples/](frontend_examples/).

## Key Views

| View | Purpose |
|------|---------|
| **Dashboard** | Project overview, progress stats (X of 300 selected) |
| **Selection Gallery** | Grid of all photos — select primaries, toggle alternate mode, assign alternates |
| **Comparison** | Primary photo (large) vs. alternates (sidebar) — swap, confirm, reject |
| **Tournament** | Manually triggered bracket elimination to cut from N to 25 |
| **Export** | Review final 25, export filenames |

## Data Model (high level)

- **Photo** — filename, directory path, position/order, status (unreviewed / selected / rejected / alternate), metadata (reserved for future EXIF)
- **AlternateGroup** — groups a primary photo with its alternates; tracks which photo is the current primary
- **TournamentMatch** — two photos, a winner, round number

## Testing

Not aiming for full coverage — this is a personal tool, not production software. But each feature should have basic tests covering the important logic. Focus on:

- **Context/business logic tests** — e.g. selecting a photo, swapping a primary, tournament bracket advancement. These are cheap to write and catch real bugs.
- **LiveView tests** — verify that key interactions work (clicking select, toggling alternate mode, swap). Don't test every CSS class.
- **Skip** — no need for extensive edge-case tests, performance tests, or integration tests against the browser.

Rule of thumb: if a function makes a decision or changes state, it should have a test. If it just renders data, it probably doesn't need one.

Run tests with `cd src && mix test`.

## What's in the repo

- `DESIGN.md` — Full design system spec (colors, typography, components)
- `frontend_examples/` — Static HTML mockups for each view (comparison, tournament, gallery, export, dashboard)