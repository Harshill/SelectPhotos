<!DOCTYPE html>

<html class="dark" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;700;800&amp;family=Inter:wght@400;500;600&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            colors: {
              "surface-container-highest": "#353534",
              "surface-container-lowest": "#0e0e0e",
              "on-secondary-container": "#98b5f3",
              "tertiary-fixed-dim": "#ffb595",
              "surface-variant": "#353534",
              "on-surface-variant": "#c1c6d7",
              "on-tertiary-fixed-variant": "#7c2e00",
              "secondary": "#adc6ff",
              "inverse-on-surface": "#313030",
              "surface-container": "#201f1f",
              "on-error-container": "#ffdad6",
              "on-secondary-fixed": "#001a41",
              "surface-tint": "#7bd0ff",
              "on-tertiary-fixed": "#351000",
              "on-primary": "#003549",
              "error": "#ffb4ab",
              "tertiary": "#ffb595",
              "error-container": "#93000a",
              "surface-bright": "#393939",
              "surface-dim": "#131313",
              "surface-container-high": "#2a2a2a",
              "surface-container-low": "#1c1b1b",
              "on-secondary": "#082f65",
              "primary": "#7bd0ff",
              "surface": "#131313",
              "tertiary-fixed": "#ffdbcc",
              "on-error": "#690005",
              "on-surface": "#e5e2e1",
              "on-tertiary": "#571e00",
              "tertiary-container": "#ef6719",
              "on-primary-fixed-variant": "#004c69",
              "inverse-surface": "#e5e2e1",
              "secondary-container": "#26467d",
              "outline": "#8b90a0",
              "on-primary-fixed": "#001e2c",
              "primary-container": "#009bd1",
              "secondary-fixed": "#d8e2ff",
              "outline-variant": "#414755",
              "inverse-primary": "#00668a",
              "primary-fixed": "#c4e7ff",
              "secondary-fixed-dim": "#adc6ff",
              "background": "#131313",
              "primary-fixed-dim": "#7bd0ff",
              "on-tertiary-container": "#4c1a00",
              "on-primary-container": "#002d40",
              "on-secondary-fixed-variant": "#26467d",
              "on-background": "#e5e2e1"
            },
            fontFamily: {
              "headline": ["Manrope"],
              "body": ["Inter"],
              "label": ["Inter"]
            },
            borderRadius: {"DEFAULT": "0.125rem", "lg": "0.25rem", "xl": "0.5rem", "full": "0.75rem"},
          },
        },
      }
    </script>
<style>
      .material-symbols-outlined {
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
      }
      .glass-hud {
        background: rgba(53, 53, 52, 0.8);
        backdrop-filter: blur(12px);
      }
      .selection-gradient {
        background: linear-gradient(135deg, #7BD0FF 0%, #009BD1 100%);
      }
    </style>
</head>
<body class="bg-surface text-on-surface font-body selection:bg-primary selection:text-on-primary">
<!-- TopNavBar Implementation -->
<nav class="bg-[#131313] dark:bg-zinc-950 docked full-width top-0 z-50 flex justify-between items-center w-full px-6 h-16 fixed top-0 left-0">
<div class="flex items-center gap-8">
<span class="text-xl font-extrabold tracking-tighter text-[#E5E2E1] dark:text-[#E5E2E1] font-headline">The Digital Darkroom</span>
<div class="hidden md:flex gap-6 items-center">
<a class="font-['Manrope'] font-bold text-sm tracking-wide text-[#7BD0FF] border-b-2 border-[#7BD0FF] pb-1" href="#">Dashboard</a>
<a class="font-['Manrope'] font-bold text-sm tracking-wide text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Gallery</a>
<a class="font-['Manrope'] font-bold text-sm tracking-wide text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Compare</a>
<a class="font-['Manrope'] font-bold text-sm tracking-wide text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Tournament</a>
<a class="font-['Manrope'] font-bold text-sm tracking-wide text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Export</a>
</div>
</div>
<div class="flex items-center gap-4">
<div class="relative hidden sm:block">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant text-sm">search</span>
<input class="bg-surface-container-high border-none rounded-lg pl-10 pr-4 py-1.5 text-sm focus:ring-1 focus:ring-primary w-64 text-on-surface" placeholder="Search project..." type="text"/>
</div>
<button class="p-2 text-on-surface-variant hover:bg-zinc-800/50 transition-all duration-200 rounded-full">
<span class="material-symbols-outlined">settings</span>
</button>
<button class="p-2 text-on-surface-variant hover:bg-zinc-800/50 transition-all duration-200 rounded-full">
<span class="material-symbols-outlined">account_circle</span>
</button>
</div>
</nav>
<!-- SideNavBar Implementation -->
<aside class="bg-[#1C1B1B] dark:bg-zinc-900 shadow-2xl shadow-black/50 fixed left-0 top-0 h-full flex flex-col py-8 px-4 docked left-0 h-screen w-64 pt-24">
<div class="mb-10 px-2">
<h2 class="text-lg font-bold text-[#E5E2E1] font-headline">Project Alpha</h2>
<p class="text-xs font-medium text-on-surface-variant opacity-70 uppercase tracking-widest mt-1">50 of 300 selected</p>
</div>
<nav class="flex-1 flex flex-col gap-1">
<a class="flex items-center gap-3 py-3 px-4 rounded transition-all text-[#7BD0FF] bg-[#26467D]/20 border-r-4 border-[#7BD0FF] font-['Inter'] text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined text-sm">dashboard</span>
<span>Overview</span>
</a>
<a class="flex items-center gap-3 py-3 px-4 rounded transition-all text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] font-['Inter'] text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined text-sm">grid_view</span>
<span>Selection</span>
</a>
<a class="flex items-center gap-3 py-3 px-4 rounded transition-all text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] font-['Inter'] text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined text-sm">compare</span>
<span>Comparison</span>
</a>
<a class="flex items-center gap-3 py-3 px-4 rounded transition-all text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] font-['Inter'] text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined text-sm">emoji_events</span>
<span>Tournament</span>
</a>
<a class="flex items-center gap-3 py-3 px-4 rounded transition-all text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] font-['Inter'] text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined text-sm">ios_share</span>
<span>Final Export</span>
</a>
</nav>
<button class="mt-auto selection-gradient text-on-primary font-bold py-3 px-4 rounded-xl text-xs uppercase tracking-widest shadow-lg shadow-primary/20">
            Finalize Selection
        </button>
</aside>
<!-- Main Canvas -->
<main class="ml-64 pt-24 px-10 pb-12 min-h-screen">
<header class="mb-12">
<h1 class="font-headline font-extrabold text-4xl text-on-surface tracking-tight mb-2">Project Dashboard</h1>
<p class="text-on-surface-variant font-body">Manage your curation workflow and selection progress for Project Alpha.</p>
</header>
<!-- Bento Grid Layout -->
<div class="grid grid-cols-12 gap-6">
<!-- Summary Stats Card -->
<div class="col-span-12 lg:col-span-4 flex flex-col gap-6">
<div class="bg-surface-container-low p-8 rounded-xl border border-outline-variant/10">
<div class="flex justify-between items-start mb-8">
<div>
<span class="text-xs font-bold uppercase tracking-widest text-on-surface-variant mb-1 block">Import Summary</span>
<h3 class="text-3xl font-headline font-bold text-on-surface">300 Photos</h3>
</div>
<div class="bg-surface-container-high p-3 rounded-lg">
<span class="material-symbols-outlined text-primary">photo_library</span>
</div>
</div>
<div class="space-y-6">
<div>
<div class="flex justify-between text-xs font-bold uppercase tracking-widest text-on-surface-variant mb-3">
<span>Selection Progress</span>
<span class="text-primary">0%</span>
</div>
<div class="w-full h-2 bg-surface-container-highest rounded-full overflow-hidden">
<div class="w-0 h-full selection-gradient rounded-full transition-all duration-500"></div>
</div>
<div class="mt-3 text-xs text-on-surface-variant">
                                0 / 25 target images selected
                            </div>
</div>
<button class="w-full selection-gradient text-on-primary font-headline font-extrabold py-4 rounded-xl text-lg flex items-center justify-center gap-2 group">
<span>Start Selection</span>
<span class="material-symbols-outlined transition-transform group-hover:translate-x-1">arrow_forward</span>
</button>
</div>
</div>
<!-- Recent Tags Card -->
<div class="bg-surface-container-low p-6 rounded-xl border border-outline-variant/10">
<h4 class="text-xs font-bold uppercase tracking-widest text-on-surface-variant mb-4">Project Labels</h4>
<div class="flex flex-wrap gap-2">
<span class="px-3 py-1 bg-secondary-container text-on-secondary-container text-xs font-medium rounded-full">Landscape</span>
<span class="px-3 py-1 bg-surface-container-highest text-on-surface-variant text-xs font-medium rounded-full">Golden Hour</span>
<span class="px-3 py-1 bg-surface-container-highest text-on-surface-variant text-xs font-medium rounded-full">Raw</span>
<span class="px-3 py-1 bg-surface-container-highest text-on-surface-variant text-xs font-medium rounded-full">Architecture</span>
</div>
</div>
</div>
<!-- Preview Gallery Grid -->
<div class="col-span-12 lg:col-span-8 bg-surface-container-low rounded-xl border border-outline-variant/10 p-2 overflow-hidden">
<div class="p-6 flex justify-between items-center">
<h4 class="text-xs font-bold uppercase tracking-widest text-on-surface-variant">Import Preview</h4>
<button class="text-xs font-bold text-primary flex items-center gap-1 hover:underline">
                        View All <span class="material-symbols-outlined text-sm">open_in_new</span>
</button>
</div>
<div class="grid grid-cols-2 md:grid-cols-3 gap-2 h-[500px]">
<div class="relative group overflow-hidden rounded-lg bg-surface-container-high">
<img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="Dramatic mountain range at sunset" src="https://lh3.googleusercontent.com/aida-public/AB6AXuC_ClvQH1Bec7MJ3LBtGRYX9SrYSZpTxkCnKLYm4afcNKu0J7ius1Xv9QfTLBebnITrKjXreDVsRIlaNg2PpmvDhBLFMqCBs0iMFprs8iQEMK_L8Q3Wok5sGhnOcusRrKKxCeJYX1S24yFlQQUo8rq0a3KJNWJ0C4FSRb2i1s04ttmWTaJuZrswoX7gyXNl9ooaljABWbJBNb-p9Jw_D0Znb908QNwZxfzNs415MZxCToniihujCWa7Myz7IWBn6Ua8KBz6PBxaUuRK"/>
<div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex items-end p-4">
<span class="text-xs font-medium text-white">DSC0412.ARW</span>
</div>
</div>
<div class="relative group overflow-hidden rounded-lg bg-surface-container-high">
<img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="Misty forest landscape in morning light" src="https://lh3.googleusercontent.com/aida-public/AB6AXuB7xv1cNGU9w7zN1pjnMZ-ZhA5zYe9ljZsxw-nfk3OuU_SyLbYxXi95HBM-pscKVpB0-YdJzdntcCA12irxkJ-tKU3k2YZQdpsQKBMx4uveCkbdhlSZdda7kYgzeESWwbq4JUei4VMm10zqceVqt3JNjwQeiperu2az-HBZYB09g_9b5ZwTLD1P3RsVFp6ySM6MLkAHSGqxvzBBFnqB3qpm1_WV9ThnrVfXYLYZsgTr-q6WaezoZL3OBGEhvaDlhLe7BXGdPBrorZDb"/>
<div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex items-end p-4">
<span class="text-xs font-medium text-white">DSC0413.ARW</span>
</div>
</div>
<div class="relative group overflow-hidden rounded-lg bg-surface-container-high col-span-1 md:row-span-2">
<img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="Crystal clear mountain lake reflection" src="https://lh3.googleusercontent.com/aida-public/AB6AXuD65lHRUgzRnp5ezrybO5IB4ewTrCXLmQ64kpPJnIeovZ0AjVzoA611Cv0Q2v3oFcEI7ulWBtdl47XZpPSPK0G7NVssRU8R17LRUp19QBLlWLcfGdtyrLswsjArf0JkWo-OGSKEyEwamcN80fVrcjOJD4py_h_f3ZsfIwUvcYPW9k1_Z6r8um8T8ijelwP4yS7LuFcYdmoKZhOsbkgkJZh08c7CZ2eVTB2JwwLDgD6mySyFgZy1_CRVnZag6Xx309s-slG_GHj0mVl0"/>
<div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex items-end p-4">
<span class="text-xs font-medium text-white">DSC0414.ARW</span>
</div>
</div>
<div class="relative group overflow-hidden rounded-lg bg-surface-container-high">
<img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="Sunlight filtering through dense woods" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDqg7kL9iLcb_yiRvRqV1_lUUa3Sgl9_acUj4pTVg-YDHnZx_w2PqN0UOaS3_LQ-lmkBuxrOlUH290GEKtHIr0Sn4tVhcIuqrQ7jna-3-yhQI8NipjC-NNHEcT0u7xQ1_fTnHRp1dJ2_9KETZuNHvxiSeNbxC9KBIqMmPnbps3BUuQuXtxJsF0dYYXOiCtMU_ByYV_dU2yQHRa087A2ezWMmQYcbCpVkvTAM0QpWKzg1BWGw6nUGWeEMf4p6hnFv1TPt7sK1z_T-zu2"/>
<div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex items-end p-4">
<span class="text-xs font-medium text-white">DSC0415.ARW</span>
</div>
</div>
<div class="relative group overflow-hidden rounded-lg bg-surface-container-high">
<img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="Lush green valley under blue sky" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDu2vcPbxVZ8rGn6Iw6Gby1tHMEYhjqD9uDlltUvMGzTYxidYnBgGjqZewbfM7w-F67cQYUTPVpMD7tsQLzfcGF9DMyFf2L4Kd6jfl8pzg1EvEjHHDK1xCCgjCw7jS-qzsRhoqx8wgfxBtvA7H5ZRrO1r4Ot3vpB-UbvbRVqCp2IaA-lZzytAbKs_9YPJEC2dw9m7w_fwRJD7jz19nZI-FgxzlZvqKOBFSkZBSfRBpVz90w5CzQ6psyVGmb2IxfZZBSDPw1QSIPpJgM"/>
<div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex items-end p-4">
<span class="text-xs font-medium text-white">DSC0416.ARW</span>
</div>
</div>
</div>
</div>
<!-- Floating Info Bar (Glassmorphism) -->
<div class="col-span-12 glass-hud p-4 rounded-xl border border-white/5 flex items-center justify-between mt-6">
<div class="flex items-center gap-6">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-on-surface-variant text-sm">schedule</span>
<span class="text-xs text-on-surface-variant">Last activity: 2 hours ago</span>
</div>
<div class="h-4 w-px bg-outline-variant/30"></div>
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-on-surface-variant text-sm" style="font-variation-settings: 'FILL' 1;">cloud_done</span>
<span class="text-xs text-on-surface-variant">All assets synced</span>
</div>
</div>
<div class="flex gap-4">
<button class="text-xs font-bold uppercase tracking-widest py-2 px-4 hover:bg-white/5 rounded-lg transition-colors">Edit Project Details</button>
<button class="text-xs font-bold uppercase tracking-widest py-2 px-4 hover:bg-white/5 rounded-lg transition-colors text-error">Archive Project</button>
</div>
</div>
</div>
</main>
<!-- Mobile Navigation Suppressed per Rule: Navigation shell Pivot -->
<div class="md:hidden fixed bottom-0 left-0 w-full bg-[#131313] px-6 py-4 flex justify-between items-center z-50">
<button class="text-primary flex flex-col items-center gap-1">
<span class="material-symbols-outlined">dashboard</span>
<span class="text-[10px] font-bold uppercase tracking-tighter">Home</span>
</button>
<button class="text-on-surface-variant flex flex-col items-center gap-1 opacity-60">
<span class="material-symbols-outlined">grid_view</span>
<span class="text-[10px] font-bold uppercase tracking-tighter">Cull</span>
</button>
<button class="text-on-surface-variant flex flex-col items-center gap-1 opacity-60">
<span class="material-symbols-outlined">settings</span>
<span class="text-[10px] font-bold uppercase tracking-tighter">Project</span>
</button>
</div>
</body></html>