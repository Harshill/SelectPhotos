# UI Polish Summary

## What changed

### Root layout (`src/lib/select_photos_web/components/layouts/root.html.heex`)
- Added **Material Symbols Outlined** icon font

### CSS (`src/assets/css/app.css`)
- Added `.material-symbols-outlined` base styling
- Added `.glass-panel` (glassmorphism with backdrop blur)
- Added `.selection-gradient` (primary CTA gradient)
- Added `.photo-card-gradient` (hover overlay)
- Added `.custom-scrollbar` and `.hide-scrollbar` utilities

### Shared layout (`src/lib/select_photos_web/components/layouts.ex`)
- Added **sidebar navigation** with active state highlighting (blue text + accent border)
- Added **active nav link highlighting** in top bar (underline on current page)
- Added **settings/account icons** to top bar using Material Symbols
- Added **project progress bar** in sidebar
- Added **"Finalize Selection" CTA** at sidebar bottom
- Accepts `active_page`, `selected_count`, `total_count` attrs

### Dashboard (`src/lib/select_photos_web/live/dashboard_live.ex`)
- Material icon for import summary card (`photo_library`)
- Selection gradient CTA with arrow icon
- Glass panel workflow status bar with `check_circle` icons
- `open_in_new` icon on "View All" link

### Gallery (`src/lib/select_photos_web/live/gallery_live.ex`)
- Redesigned toolbar with title + filter chips (matching `photos_copy.md`)
- Photo cards now `aspect-[4/5]` with hover zoom and gradient overlay
- Material icon buttons (close/star) replacing text characters
- Star badge on primary selections

### Comparison (`src/lib/select_photos_web/live/comparison_live.ex`)
- "Live Comparison" indicator badge
- Glass panel HUD on primary photo with "SEED CANDIDATE" label
- "Master View" label badge
- Material icons for swap/reject/zoom buttons
- Footer toolbar matching the frontend example

### Tournament (`src/lib/select_photos_web/live/tournament_live.ex`)
- Glass panel HUD with bracket icon and glowing progress bar
- `check_circle` icon on hover for "Pick Winner" buttons
- Floating bottom toolbar (pill style) with undo/exit controls
- Trophy icon for setup and finished states

### Export (`src/lib/select_photos_web/live/export_live.ex`)
- Two-column layout: file manifest list + photo grid (matching `export_summary.md`)
- Scrollable manifest with hover states
- Export action card with download icon
- Photo grid with hover overlays and numbering
