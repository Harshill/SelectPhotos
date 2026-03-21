# Design System Specification: The Digital Darkroom

## 1. Overview & Creative North Star
**Creative North Star: "The Silent Curator"**

This design system is built to disappear. In a photography selection app, the UI must never compete with the asset; it should act as a high-end, darkened gallery wall that recedes to prioritize color accuracy and composition. We move beyond "template" looks by rejecting standard borders and rigid, generic grids in favor of **Tonal Layering**. By using dense, organized metadata balanced against expansive, high-contrast display type, we create a "Pro-Tool" aesthetic—reminiscent of tactile darkroom equipment but polished with modern web fluidities.

## 2. Colors & Surface Philosophy
The palette is rooted in deep charcoals to minimize eye fatigue during long culling sessions.

### Surface Hierarchy & The "No-Line" Rule
Traditional 1px borders are strictly prohibited for sectioning. We define space through **Background Shifts**.
* **The Global Canvas:** Use `surface` (#131313) for the primary background.
* **The Workstation:** Use `surface_container_low` (#1C1B1B) for large utility panels (e.g., the Filmstrip).
* **The Focused Asset:** Use `surface_container_high` (#2A2A2A) for active workspace areas.
* **The Metadata Card:** Use `surface_container_highest` (#353534) to make an element "pop" forward without a border.

### The "Glass & Gradient" Rule
To elevate the "Selection Blue" (`primary`: #7BD0FF), avoid flat fills for large areas.
* **Signature Gradients:** Use a linear transition from `primary` (#7BD0FF) to `primary_container` (#009BD1) for active selection states or primary CTA backgrounds. This adds a "backlit" quality common in high-end hardware.
* **Glassmorphism:** Floating inspectors or HUDs (Heads-Up Displays) must use `surface_variant` (#353534) at 80% opacity with a `backdrop-filter: blur(12px)`. This keeps the photographer tethered to the image behind the UI.

## 3. Typography
We employ a dual-typeface strategy to balance editorial authority with technical utility.

* **Display & Headlines (Manrope):** Used for gallery titles and high-level navigation. Manrope’s geometric nature feels engineered and modern. Use `headline-sm` (1.5rem) for folder names to create an editorial feel.
* **The Utility Layer (Inter):** All metadata (ISO, Shutter Speed, Aperture) and UI labels must use Inter.
* **Metadata:** Use `label-sm` (#0.6875rem) with `on_surface_variant` (#C1C6D7) for a subdued, technical look.
* **Primary Actions:** Use `title-sm` (1rem, Medium weight) for button labels to ensure instant legibility against dark backgrounds.

## 4. Elevation & Depth
In this system, depth is a product of light, not lines.

* **Tonal Layering:** Instead of shadows, stack containers. Place a `surface_container_highest` photo card on a `surface_dim` background to create a "Natural Lift."
* **Ambient Shadows:** For floating modals (e.g., "Export Settings"), use a massive, diffused shadow: `box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5)`. The shadow must feel like an occlusion of light, not a black smudge.
* **The Ghost Border:** If high-contrast accessibility is required, use `outline_variant` (#414755) at 20% opacity. Never use a 100% opaque border; it "traps" the image and breaks the immersive flow.

## 5. Components

### Photo Cards & Grids
* **Corner Radius:** Consistently use `lg` (0.5rem / 8px) for all photo containers.
* **Spacing:** Use `spacing-4` (0.9rem) between grid items.
* **Selection State:** Indicate selection with a 2px `primary` (#7BD0FF) inner glow and a `primary` glass-morphic icon overlay in the top-right corner.
* **No Dividers:** Separate "Favorite" and "Reject" icon buttons using `spacing-2` (0.4rem) of horizontal gap rather than a vertical line.

### Buttons
* **Primary:** Gradient fill (`primary` to `primary_container`). `on_primary` (#003549) text. `xl` (0.75rem) roundedness for a "pill" feel on small actions, or `lg` (0.5rem) for toolbars.
* **Tertiary (Ghost):** No background. Use `on_surface` (#E5E2E1) text. On hover, shift background to `surface_bright` (#393939).

### Tooltips & HUDs
* **Styling:** Use `surface_container_highest` with a subtle `outline` (#8B90A0) at 10% opacity.
* **Interactions:** Tooltips should have a 150ms ease-in delay to prevent visual noise while the user quickly scans the grid.

### Selection Chips
* **State:** Unselected chips use `surface_container_high`. Selected chips use `secondary_container` (#26467D) with `on_secondary_container` (#98B5F3) text.

## 6. Do's and Don'ts

### Do
* **DO** use `surface_container` tiers to group related metadata (e.g., EXIF data grouped on a `surface_container_low` slab).
* **DO** use `secondary_fixed_dim` (#ADC6FF) for "Compare" modes to distinguish from the "Primary Selection" blue.
* **DO** prioritize whitespace (using `spacing-8` or `10`) over lines to separate the sidebars from the main stage.

### Don't
* **DON'T** use pure black (#000000) for backgrounds. It causes "smearing" on many OLED screens and feels too heavy. Use `surface` (#131313).
* **DON'T** use `error` (#FFB4AB) for "Rejected" photos. Instead, use a dimmed `on_surface_variant` at 40% opacity to visually "recede" the photo. Reserve red for system errors only.
* **DON'T** use 100% white for text. Use `on_surface` (#E5E2E1) to reduce contrast-glare on dark backgrounds.

---
**Director's Note:**
Remember, the user is an artist. They are looking for "The Shot." Every pixel you place should help them find it faster. If a UI element doesn't help them decide between two frames, it shouldn't be there. Keep it lean, keep it dark, and let the light come from the photography.