<!DOCTYPE html>

<html class="dark" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>The Digital Darkroom | Comparison Mode</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;700;800&amp;family=Inter:wght@400;500;600&amp;display=swap" rel="stylesheet"/>
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
                    borderRadius: { "DEFAULT": "0.125rem", "lg": "0.25rem", "xl": "0.5rem", "full": "0.75rem" },
                },
            },
        }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .glass-panel {
            background: rgba(53, 53, 52, 0.8);
            backdrop-filter: blur(12px);
        }
        .primary-gradient {
            background: linear-gradient(135deg, #7BD0FF 0%, #009BD1 100%);
        }
        .custom-scrollbar::-webkit-scrollbar {
            width: 4px;
        }
        .custom-scrollbar::-webkit-scrollbar-track {
            background: transparent;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb {
            background: #414755;
            border-radius: 10px;
        }
    </style>
</head>
<body class="bg-surface text-on-surface font-body selection:bg-primary/30 overflow-hidden">
<!-- Top Navigation Bar -->
<header class="bg-[#131313] flex justify-between items-center w-full px-6 h-16 docked full-width top-0 z-50">
<div class="flex items-center gap-8">
<span class="text-xl font-extrabold tracking-tighter text-[#E5E2E1]">The Digital Darkroom</span>
<nav class="hidden md:flex items-center gap-6 font-['Manrope'] font-bold text-sm tracking-wide">
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Dashboard</a>
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Gallery</a>
<a class="text-[#7BD0FF] border-b-2 border-[#7BD0FF] pb-1" href="#">Compare</a>
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Tournament</a>
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Export</a>
</nav>
</div>
<div class="flex items-center gap-4">
<button class="p-2 text-[#C1C6D7] hover:bg-zinc-800/50 transition-all duration-200 rounded-lg active:scale-95 opacity-80">
<span class="material-symbols-outlined">settings</span>
</button>
<button class="p-2 text-[#C1C6D7] hover:bg-zinc-800/50 transition-all duration-200 rounded-lg active:scale-95 opacity-80">
<span class="material-symbols-outlined">account_circle</span>
</button>
</div>
</header>
<div class="flex h-[calc(100vh-64px)] overflow-hidden">
<!-- Sidebar Navigation -->
<aside class="bg-[#1C1B1B] fixed left-0 top-16 h-full w-64 flex flex-col py-8 px-4 shadow-2xl shadow-black/50 z-40">
<div class="mb-10">
<h2 class="text-lg font-bold text-[#E5E2E1] font-headline mb-1">Project Alpha</h2>
<p class="font-['Inter'] text-[10px] font-medium uppercase tracking-widest text-[#C1C6D7]">50 of 300 selected</p>
<!-- Progress Bar -->
<div class="mt-4 h-1 w-full bg-surface-container-highest rounded-full overflow-hidden">
<div class="h-full w-1/6 primary-gradient"></div>
</div>
</div>
<nav class="flex flex-col gap-2 flex-grow">
<a class="flex items-center gap-3 py-3 px-4 font-['Inter'] text-xs font-medium uppercase tracking-widest text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] transition-all rounded-lg" href="#">
<span class="material-symbols-outlined">dashboard</span>
<span>Overview</span>
</a>
<a class="flex items-center gap-3 py-3 px-4 font-['Inter'] text-xs font-medium uppercase tracking-widest text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] transition-all rounded-lg" href="#">
<span class="material-symbols-outlined">grid_view</span>
<span>Selection</span>
</a>
<a class="flex items-center gap-3 py-3 px-4 font-['Inter'] text-xs font-medium uppercase tracking-widest text-[#7BD0FF] bg-[#26467D]/20 border-r-4 border-[#7BD0FF] transition-all" href="#">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">compare</span>
<span>Comparison</span>
</a>
<a class="flex items-center gap-3 py-3 px-4 font-['Inter'] text-xs font-medium uppercase tracking-widest text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] transition-all rounded-lg" href="#">
<span class="material-symbols-outlined">emoji_events</span>
<span>Tournament</span>
</a>
<a class="flex items-center gap-3 py-3 px-4 font-['Inter'] text-xs font-medium uppercase tracking-widest text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] transition-all rounded-lg" href="#">
<span class="material-symbols-outlined">ios_share</span>
<span>Final Export</span>
</a>
</nav>
<button class="mt-auto primary-gradient text-on-primary py-3 rounded-lg font-['Inter'] text-xs font-bold uppercase tracking-widest active:scale-95 transition-transform">
                Finalize Selection
            </button>
</aside>
<!-- Main Content Area -->
<main class="ml-64 flex-grow p-6 flex flex-col gap-6 overflow-hidden">
<!-- Comparison Header -->
<div class="flex justify-between items-end">
<div>
<h1 class="font-headline font-extrabold text-2xl text-on-surface tracking-tight">Image Refinement</h1>
<p class="text-on-surface-variant text-sm font-body">Set 12 of 45: Exploring Depth of Field variations</p>
</div>
<div class="flex gap-3">
<div class="bg-surface-container-high px-3 py-1.5 rounded-lg flex items-center gap-2 border border-outline-variant/10">
<span class="w-2 h-2 rounded-full bg-primary animate-pulse"></span>
<span class="text-xs font-bold font-label uppercase tracking-tighter text-on-surface-variant">Live Comparison</span>
</div>
</div>
</div>
<!-- Focus Workspace (Asymmetric Layout) -->
<div class="flex-grow flex gap-6 min-h-0">
<!-- Left Side: Large Seed Photo -->
<div class="flex-[3] relative group bg-surface-container-low rounded-xl overflow-hidden shadow-2xl border border-outline-variant/5">
<img alt="Seed candidate" class="w-full h-full object-cover" data-alt="Main portrait photo being compared with soft background bokeh" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAKEGFjtu573tnpX5sOZYjPcPTpJdhHroC6Y7baOb6CNXHR9o5uAfkULRiZ35PxU_ldI5t5yA6tpyrPV9LL8V4n-25kPF2Iw1bsDnfr4FZ9sy0sDULmz5Xdf7_KyEJMx0lXV1mqk--sxK6qcwbF1ja_CkATRo5YURf2hBJQgZTzIRArROTEtnY7aQRYHQ82NZeTbh96sg2F-zNTR4jbZy-F1N--DPXabZSvxiUCisyaiB5emInfack3n0X-IzsACNmL694ckC2zpqhh"/>
<!-- Floating HUD -->
<div class="absolute bottom-6 left-6 right-6 glass-panel p-4 rounded-xl border border-outline-variant/20 flex justify-between items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
<div class="flex flex-col">
<span class="text-primary font-headline font-bold text-sm tracking-wide">SEED CANDIDATE</span>
<div class="flex gap-4 mt-1 text-[10px] text-on-surface-variant uppercase tracking-widest font-body">
<span>ISO 100</span>
<span>85mm</span>
<span>f/1.4</span>
<span>1/250s</span>
</div>
</div>
<div class="flex gap-2">
<button class="p-2 bg-surface-container rounded-lg text-on-surface hover:bg-surface-bright transition-colors">
<span class="material-symbols-outlined">zoom_in</span>
</button>
<button class="p-2 bg-surface-container rounded-lg text-on-surface hover:bg-surface-bright transition-colors">
<span class="material-symbols-outlined">history</span>
</button>
</div>
</div>
<!-- Label -->
<div class="absolute top-6 left-6 bg-primary/90 text-on-primary px-3 py-1 rounded-full text-[10px] font-bold tracking-widest uppercase">
                        Master View
                    </div>
</div>
<!-- Right Side: Alternatives Vertical Grid -->
<div class="flex-[1] flex flex-col gap-4 overflow-y-auto pr-2 custom-scrollbar">
<!-- Alternative 1 -->
<div class="bg-surface-container-high p-3 rounded-xl border border-outline-variant/10 group">
<div class="relative aspect-video rounded-lg overflow-hidden mb-3">
<img alt="Alternative view 1" class="w-full h-full object-cover" data-alt="Alternative landscape photography frame focusing on foreground detail" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBWDwLpUo-Si3Qax96nRpqrh1Eim910Df2oWF8Og8NGCK3brrPpIClLdH0U9-tjx-UPy9CaBa2p5TXN_IjU5aGbZCrWXqMggwDQ6Qw0LcSLW1E4wvIgJE_qWfTAhFSQaGXphh7XE7dqhMm5XA7lIWHlnQXpnnytS2i_2VcCQC1mnbPXX5tKVmkkPApj9YwWVKNVqBIGRcgYX0EPe0Ws8otkHqcuEbzD55dVwszeO8GhTVM8ni6B_mQ7FJJ84uOQC_Di1tGuK8cysMSP"/>
<button class="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 flex items-center justify-center transition-opacity">
<div class="bg-surface-container-highest px-4 py-2 rounded-full flex items-center gap-2 text-xs font-bold text-on-surface">
<span class="material-symbols-outlined text-sm">swap_horiz</span> Swap Seed
                                </div>
</button>
</div>
<div class="flex justify-between items-center">
<div class="flex flex-col">
<span class="text-xs font-bold font-headline text-on-surface">Candidate B</span>
<span class="text-[10px] text-on-surface-variant font-body uppercase">High Contrast</span>
</div>
<div class="flex gap-1.5">
<button class="bg-surface-container text-on-surface hover:text-primary p-2 rounded-lg flex items-center justify-center hover:bg-surface-bright transition-all group/swap" title="Swap with Master">
<span class="material-symbols-outlined text-base">swap_horiz</span>
</button>
<button class="primary-gradient text-on-primary p-2 rounded-lg flex items-center justify-center hover:shadow-[0_0_15px_rgba(123,208,255,0.4)] transition-all">
<span class="material-symbols-outlined text-base" style="font-variation-settings: 'FILL' 1;">check_circle</span>
</button>
</div>
</div>
</div>
<!-- Alternative 2 -->
<div class="bg-surface-container-high p-3 rounded-xl border border-outline-variant/10 group">
<div class="relative aspect-video rounded-lg overflow-hidden mb-3">
<img alt="Alternative view 2" class="w-full h-full object-cover" data-alt="Close up photography of camera lens elements" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAfxkMW1KUiCAjev2cpvpd4iOCuKLtD33N3le9rO32NUmMfnGixbAWYtWrB-QEepR2-VSlcP8dGhHh8hHdcaNhgRa66kPFEQyYkksZ45vBSS9p0xJ2N-wiAF9wQqY0jBpqFQJfWILvGekpR8nybU-_KrMKV21FEHkB0ov2oqks9okIpDMP7m3hVpdevViMmYQCAIPntf5UQo17PvWOxKEAQryxT05FC7vf-b09i8bC-oMRuhaDa7BSrx2yC4XalzvYe9-o91iywcPaJ"/>
<button class="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 flex items-center justify-center transition-opacity">
<div class="bg-surface-container-highest px-4 py-2 rounded-full flex items-center gap-2 text-xs font-bold text-on-surface">
<span class="material-symbols-outlined text-sm">swap_horiz</span> Swap Seed
                                </div>
</button>
</div>
<div class="flex justify-between items-center">
<div class="flex flex-col">
<span class="text-xs font-bold font-headline text-on-surface">Candidate C</span>
<span class="text-[10px] text-on-surface-variant font-body uppercase">Wide Aperture</span>
</div>
<div class="flex gap-1.5">
<button class="bg-surface-container text-on-surface hover:text-primary p-2 rounded-lg flex items-center justify-center hover:bg-surface-bright transition-all group/swap" title="Swap with Master">
<span class="material-symbols-outlined text-base">swap_horiz</span>
</button>
<button class="bg-surface-container text-on-surface-variant p-2 rounded-lg flex items-center justify-center hover:bg-surface-bright transition-all">
<span class="material-symbols-outlined text-base">check_circle</span>
</button>
</div>
</div>
</div>
<!-- Alternative 3 -->
<div class="bg-surface-container-high p-3 rounded-xl border border-outline-variant/10 group">
<div class="relative aspect-video rounded-lg overflow-hidden mb-3">
<img alt="Alternative view 3" class="w-full h-full object-cover" data-alt="Atmospheric dark room aesthetic with dim lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDetVP-1JxqhTwoXEQqDNAl3UeY-i1Cym9H3L7w7R-NnF41cQXA9Uu2wLN33-eixiAv6Bw5fOzB1E7wgzxadK8P58nj-HoLfY2uRr468jFaoP_QVJZtaQWH6-jRBmqqJUZQTlMelCaU0Sn84FsDufFnftm064v8JxGZDjN_BChZmRqbGUtTv0kFS9HC2qb9w2I8MZPPcRWfao41xAjISm6CsXw5PSWmDntORcPT5lSr1JTFwt4AmkKZPUWMiCJ6U3qScUKo8QErCCNJ"/>
<button class="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 flex items-center justify-center transition-opacity">
<div class="bg-surface-container-highest px-4 py-2 rounded-full flex items-center gap-2 text-xs font-bold text-on-surface">
<span class="material-symbols-outlined text-sm">swap_horiz</span> Swap Seed
                                </div>
</button>
</div>
<div class="flex justify-between items-center">
<div class="flex flex-col">
<span class="text-xs font-bold font-headline text-on-surface">Candidate D</span>
<span class="text-[10px] text-on-surface-variant font-body uppercase">Mono Grade</span>
</div>
<div class="flex gap-1.5">
<button class="bg-surface-container text-on-surface hover:text-primary p-2 rounded-lg flex items-center justify-center hover:bg-surface-bright transition-all group/swap" title="Swap with Master">
<span class="material-symbols-outlined text-base">swap_horiz</span>
</button>
<button class="bg-surface-container text-on-surface-variant p-2 rounded-lg flex items-center justify-center hover:bg-surface-bright transition-all">
<span class="material-symbols-outlined text-base">check_circle</span>
</button>
</div>
</div>
</div>
</div>
</div>
<!-- Footer Toolbar -->
<footer class="bg-surface-container-low h-14 rounded-xl flex items-center px-6 justify-between border border-outline-variant/5">
<div class="flex items-center gap-6">
<div class="flex -space-x-2">
<div class="w-8 h-8 rounded-full border-2 border-surface bg-surface-container-highest flex items-center justify-center text-[10px] font-bold text-primary">A</div>
<div class="w-8 h-8 rounded-full border-2 border-surface bg-surface-container-highest flex items-center justify-center text-[10px] font-bold">B</div>
<div class="w-8 h-8 rounded-full border-2 border-surface bg-surface-container-highest flex items-center justify-center text-[10px] font-bold">C</div>
<div class="w-8 h-8 rounded-full border-2 border-surface bg-surface-container-highest flex items-center justify-center text-[10px] font-bold">D</div>
</div>
<div class="h-4 w-px bg-outline-variant/20"></div>
<div class="flex items-center gap-4">
<button class="text-on-surface-variant hover:text-primary flex items-center gap-2 transition-colors">
<span class="material-symbols-outlined text-lg">flag</span>
<span class="text-xs font-bold uppercase tracking-widest font-label">Mark Set</span>
</button>
<button class="text-on-surface-variant hover:text-error flex items-center gap-2 transition-colors">
<span class="material-symbols-outlined text-lg">delete</span>
<span class="text-xs font-bold uppercase tracking-widest font-label">Reject Others</span>
</button>
</div>
</div>
<div class="flex items-center gap-3">
<button class="text-on-surface-variant text-xs font-bold uppercase tracking-widest px-4 py-2 hover:bg-surface-bright rounded-lg transition-colors">
                        Skip Set
                    </button>
<button class="primary-gradient text-on-primary px-6 py-2 rounded-lg text-xs font-bold uppercase tracking-widest shadow-lg shadow-primary/20">
                        Next Batch
                    </button>
</div>
</footer>
</main>
</div>
<!-- Background Decoration -->
<div class="fixed top-0 left-0 w-full h-full pointer-events-none -z-10 overflow-hidden opacity-20">
<div class="absolute top-[-20%] right-[-10%] w-[60%] h-[60%] rounded-full bg-primary/10 blur-[120px]"></div>
<div class="absolute bottom-[-10%] left-[-5%] w-[40%] h-[40%] rounded-full bg-secondary-container/10 blur-[100px]"></div>
</div>
</body></html>