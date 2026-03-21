# Build Summary

## What was built

A local photo culling app ("The Digital Darkroom") for selecting the best ~25 photos from a shoot of ~300.

### Tech Stack
- Elixir / Phoenix LiveView
- SQLite (in-project directory)
- Tailwind CSS + DaisyUI
- Image library (libvips) for thumbnails

### Views
| Route | View | Status |
|-------|------|--------|
| `/` | Dashboard | Stats, progress, workflow steps, photo preview |
| `/gallery` | Gallery | Photo grid, select/deselect, alternate grouping |
| `/compare` | Comparison | Primary (large) vs alternates (sidebar), swap/confirm/reject |
| `/tournament` | Tournament | Head-to-head bracket elimination |
| `/export` | Export | Review final selections, export filenames to `selects.txt` |

### Data Model
- **Photo** — filename, directory, position, status (unreviewed/selected/rejected/alternate), is_primary, alternate_group_id
- **AlternateGroup** — groups a primary with its alternates
- **TournamentMatch** — round, position, photo_left, photo_right, winner

### Key Features
- **Directory-based** — point at any folder, no upload needed
- **Alternate grouping** — select a photo (auto-becomes primary), pill toggles to alternate mode, click more photos to attach as alternates
- **Comparison view** — review each group, swap primary, confirm or reject
- **Tournament** — blocked until all alternate groups are resolved; bracket elimination to cut down to target count
- **Thumbnails** — 400px JPEGs generated via libvips, cached in `.thumbs/`, served at `/thumbs/:filename`
- **Full images** — served at `/photos/:filename` for comparison/tournament views

### Tests
21 tests covering:
- Photo loading from directory
- Selection/deselection/rejection
- Alternate group creation, adding alternates, swapping primary, removal
- Tournament creation, winner picking, round advancement, cleanup

### Running
```
cd src
mix deps.get
mix ecto.setup
mix phx.server
# open http://localhost:4005
```

Set your photo directory in `src/config/dev.exs`:
```elixir
config :select_photos, :photo_directory, Path.expand("~/path/to/photos")
```

### What's next
- UI polish to match DESIGN.md (tonal layering, glassmorphism, proper typography)
- Keyboard shortcuts
- Reset/reload functionality
