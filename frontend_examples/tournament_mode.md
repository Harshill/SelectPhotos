<!DOCTYPE html>

<html class="dark" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Tournament Mode | The Digital Darkroom</title>
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
        .glass-panel {
            background: rgba(53, 53, 52, 0.8);
            backdrop-filter: blur(12px);
        }
        .photo-gradient-overlay {
            background: linear-gradient(to bottom, transparent 60%, rgba(19, 19, 19, 0.9));
        }
        body {
            background-color: #131313;
            color: #e5e2e1;
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="overflow-hidden">
<!-- TopNavBar -->
<header class="bg-[#131313] dark:bg-zinc-950 docked full-width top-0 z-50 flex justify-between items-center w-full px-6 h-16 border-b border-outline-variant/10">
<div class="flex items-center gap-8">
<span class="text-xl font-extrabold tracking-tighter text-[#E5E2E1] dark:text-[#E5E2E1] font-headline">The Digital Darkroom</span>
<nav class="hidden md:flex items-center gap-6 font-headline font-bold text-sm tracking-wide">
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Dashboard</a>
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Gallery</a>
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Compare</a>
<a class="text-[#7BD0FF] border-b-2 border-[#7BD0FF] pb-1" href="#">Tournament</a>
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Export</a>
</nav>
</div>
<div class="flex items-center gap-4">
<div class="relative hidden sm:block">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline text-sm">search</span>
<input class="bg-surface-container-low border-none rounded-lg pl-10 pr-4 py-1.5 text-xs focus:ring-1 focus:ring-primary w-64 text-on-surface" placeholder="Search assets..." type="text"/>
</div>
<button class="p-2 text-on-surface-variant hover:bg-zinc-800/50 transition-all duration-200 rounded-full">
<span class="material-symbols-outlined" data-icon="settings">settings</span>
</button>
<button class="p-2 text-on-surface-variant hover:bg-zinc-800/50 transition-all duration-200 rounded-full">
<span class="material-symbols-outlined" data-icon="account_circle">account_circle</span>
</button>
</div>
</header>
<div class="flex h-[calc(100vh-64px)]">
<!-- SideNavBar -->
<aside class="bg-[#1C1B1B] dark:bg-zinc-900 shadow-2xl shadow-black/50 fixed left-0 top-16 h-full w-64 flex flex-col py-8 px-4 z-40">
<div class="mb-8 px-2">
<h2 class="text-lg font-bold text-[#E5E2E1] font-headline">Project Alpha</h2>
<p class="text-[10px] font-medium uppercase tracking-widest text-[#C1C6D7]/60 mt-1 font-body">50 of 300 selected</p>
</div>
<nav class="flex-1 space-y-1">
<a class="flex items-center gap-3 px-3 py-3 rounded text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] transition-all font-body text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined text-lg" data-icon="dashboard">dashboard</span>
<span>Overview</span>
</a>
<a class="flex items-center gap-3 px-3 py-3 rounded text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] transition-all font-body text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined text-lg" data-icon="grid_view">grid_view</span>
<span>Selection</span>
</a>
<a class="flex items-center gap-3 px-3 py-3 rounded text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] transition-all font-body text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined text-lg" data-icon="compare">compare</span>
<span>Comparison</span>
</a>
<a class="flex items-center gap-3 px-3 py-3 rounded text-[#7BD0FF] bg-[#26467D]/20 border-r-4 border-[#7BD0FF] font-body text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined text-lg" data-icon="emoji_events">emoji_events</span>
<span>Tournament</span>
</a>
<a class="flex items-center gap-3 px-3 py-3 rounded text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] transition-all font-body text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined text-lg" data-icon="ios_share">ios_share</span>
<span>Final Export</span>
</a>
</nav>
<div class="mt-auto pt-6 px-2 space-y-4">
<div class="bg-surface-container-high rounded-xl p-4">
<p class="text-[10px] font-bold text-on-surface-variant uppercase tracking-tighter mb-2">Tournament Progress</p>
<div class="w-full bg-surface-container-highest h-1.5 rounded-full overflow-hidden">
<div class="bg-primary h-full w-[48%]" style="box-shadow: 0 0 8px #7BD0FF;"></div>
</div>
<p class="text-[10px] text-on-surface-variant mt-2 text-right">Round 1: 12 / 25</p>
</div>
<button class="w-full bg-gradient-to-r from-primary to-primary-container text-on-primary py-3 rounded-lg font-headline font-bold text-sm hover:opacity-90 transition-opacity">
                    Finalize Selection
                </button>
</div>
</aside>
<!-- Main Stage -->
<main class="flex-1 ml-64 bg-surface p-8 flex flex-col items-center">
<!-- Tournament HUD -->
<div class="w-full max-w-5xl mb-8 flex items-center justify-between glass-panel px-8 py-4 rounded-xl border border-outline-variant/10">
<div class="flex items-center gap-4">
<div class="w-10 h-10 rounded-full bg-secondary-container flex items-center justify-center text-primary">
<span class="material-symbols-outlined" data-icon="account_tree">account_tree</span>
</div>
<div>
<h1 class="text-sm font-headline font-extrabold text-on-surface tracking-tight">Round 1: Match 12 of 25</h1>
<p class="text-[10px] font-body text-on-surface-variant uppercase tracking-widest">Selecting Top 25 from 50</p>
</div>
</div>
<div class="flex items-center gap-8">
<div class="flex flex-col items-center">
<span class="text-[10px] font-bold text-on-surface-variant/50 uppercase tracking-widest mb-1">Bracket A</span>
<div class="flex gap-1">
<div class="w-2 h-2 rounded-full bg-primary"></div>
<div class="w-2 h-2 rounded-full bg-primary"></div>
<div class="w-2 h-2 rounded-full bg-surface-container-highest"></div>
<div class="w-2 h-2 rounded-full bg-surface-container-highest"></div>
</div>
</div>
<div class="h-8 w-px bg-outline-variant/20"></div>
<div class="flex flex-col items-center">
<span class="text-[10px] font-bold text-on-surface-variant/50 uppercase tracking-widest mb-1">Remaining</span>
<span class="text-xs font-bold font-headline text-primary">13 Matches</span>
</div>
</div>
</div>
<!-- Comparison Area -->
<div class="flex-1 w-full max-w-6xl grid grid-cols-2 gap-8 items-stretch mb-8">
<!-- Competitor A -->
<div class="flex flex-col gap-4 group">
<div class="relative flex-1 rounded-xl overflow-hidden bg-surface-container-low border-2 border-transparent group-hover:border-primary/30 transition-all duration-300 shadow-2xl">
<img class="w-full h-full object-cover" data-alt="Cinematic street photography of a rainy neon city" src="https://lh3.googleusercontent.com/aida-public/AB6AXuA1CAufTjamUK1w6ZcM5dvfr-1TauYhUuObowKAVys9AFL0T3NL8J_lQqbqDvca24p17i5EPie5sMwpXuA9tNQwdOHWX2yHPPEzF8nhdZ3jsvXaP2pWfgSzP4fZahOSdG6ufPuEdhgIdskJGji6BGM--yulwRv5ek_88CN1Cw-akukqdflt2z38KbTDNXMIg1DKj5dxvQpqkhnlCTskkLrp7i7pByQkWcQL6H-_B61UqCZkiUqo6ihFIG35NGTGtBOBCxGAKt67aym8"/>
<div class="absolute inset-0 photo-gradient-overlay opacity-60"></div>
<div class="absolute top-4 left-4 glass-panel px-3 py-1.5 rounded-lg flex items-center gap-2 border border-outline-variant/20">
<span class="text-[10px] font-bold text-primary font-headline">ISO 400</span>
<div class="w-px h-3 bg-outline-variant/30"></div>
<span class="text-[10px] font-medium text-on-surface-variant">f/1.8</span>
<div class="w-px h-3 bg-outline-variant/30"></div>
<span class="text-[10px] font-medium text-on-surface-variant">1/250s</span>
</div>
<div class="absolute top-4 right-4">
<div class="bg-surface-container-highest/80 backdrop-blur text-[10px] font-bold px-2 py-1 rounded text-on-surface border border-outline-variant/20">
                                #DSC_1024
                            </div>
</div>
</div>
<button class="w-full py-4 bg-surface-container-highest hover:bg-gradient-to-r from-primary to-primary-container hover:text-on-primary transition-all duration-300 rounded-xl flex items-center justify-center gap-3 group/btn">
<span class="text-sm font-headline font-bold uppercase tracking-widest">Pick Winner</span>
<span class="material-symbols-outlined text-lg opacity-0 group-hover/btn:opacity-100 transition-opacity" data-icon="check_circle" style="font-variation-settings: 'FILL' 1;">check_circle</span>
</button>
</div>
<!-- Center Divider (VS) -->
<div class="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 z-10 hidden lg:flex items-center justify-center">
<div class="w-12 h-12 rounded-full glass-panel border border-primary/40 flex items-center justify-center shadow-[0_0_20px_rgba(123,208,255,0.2)]">
<span class="text-xs font-headline font-black text-primary italic">VS</span>
</div>
</div>
<!-- Competitor B -->
<div class="flex flex-col gap-4 group">
<div class="relative flex-1 rounded-xl overflow-hidden bg-surface-container-low border-2 border-transparent group-hover:border-primary/30 transition-all duration-300 shadow-2xl">
<img class="w-full h-full object-cover" data-alt="Breathtaking mountain range during blue hour photography" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAZ9o1w5yswkuZmeM70VQxBuZ5qM1txRSSU6GoCnf0z80gt70TMc9r6RC9JXcOAWy0VjBAJxD1kC4Gsh14-AZmMq3qshXDgC3UBspc46IJqmzUg8HwfS2WZ2Y0TY5_-h4ny0H0FNTAFSau_LXiuPHgi830prWExNv1__7AR0do098auNC4krhBVWMk3jZd2dDzIQ5pHxFAm1oqFKSTrbsb2-TqGVvW1tVw1HsdYFwO6IxlWHrnJDWA2jrzrFf67HA20uxuFiVMp6H39"/>
<div class="absolute inset-0 photo-gradient-overlay opacity-60"></div>
<div class="absolute top-4 left-4 glass-panel px-3 py-1.5 rounded-lg flex items-center gap-2 border border-outline-variant/20">
<span class="text-[10px] font-bold text-primary font-headline">ISO 100</span>
<div class="w-px h-3 bg-outline-variant/30"></div>
<span class="text-[10px] font-medium text-on-surface-variant">f/11</span>
<div class="w-px h-3 bg-outline-variant/30"></div>
<span class="text-[10px] font-medium text-on-surface-variant">2.0s</span>
</div>
<div class="absolute top-4 right-4">
<div class="bg-surface-container-highest/80 backdrop-blur text-[10px] font-bold px-2 py-1 rounded text-on-surface border border-outline-variant/20">
                                #DSC_1089
                            </div>
</div>
</div>
<button class="w-full py-4 bg-surface-container-highest hover:bg-gradient-to-r from-primary to-primary-container hover:text-on-primary transition-all duration-300 rounded-xl flex items-center justify-center gap-3 group/btn">
<span class="text-sm font-headline font-bold uppercase tracking-widest">Pick Winner</span>
<span class="material-symbols-outlined text-lg opacity-0 group-hover/btn:opacity-100 transition-opacity" data-icon="check_circle" style="font-variation-settings: 'FILL' 1;">check_circle</span>
</button>
</div>
</div>
<!-- Bottom Toolbar / Controls -->
<div class="w-full max-w-lg flex items-center justify-center gap-4 px-6 py-3 rounded-full glass-panel border border-outline-variant/10">
<button class="p-2 hover:bg-surface-container-high rounded-lg text-on-surface-variant flex items-center gap-2 transition-all">
<span class="material-symbols-outlined text-sm" data-icon="keyboard_arrow_left">keyboard_arrow_left</span>
<span class="text-[10px] font-bold uppercase tracking-widest">Undo Last</span>
</button>
<div class="w-px h-4 bg-outline-variant/20 mx-2"></div>
<button class="p-2 hover:bg-surface-container-high rounded-lg text-on-surface-variant flex items-center gap-2 transition-all">
<span class="text-[10px] font-bold uppercase tracking-widest">Toggle Stats</span>
<span class="material-symbols-outlined text-sm" data-icon="info">info</span>
</button>
<div class="w-px h-4 bg-outline-variant/20 mx-2"></div>
<button class="p-2 hover:bg-surface-container-high rounded-lg text-on-surface-variant flex items-center gap-2 transition-all">
<span class="text-[10px] font-bold uppercase tracking-widest">Exit Mode</span>
<span class="material-symbols-outlined text-sm" data-icon="close">close</span>
</button>
</div>
</main>
</div>
<!-- Mobile Navigation Overlay (Visible on small screens) -->
<nav class="md:hidden fixed bottom-0 left-0 w-full bg-surface border-t border-outline-variant/10 flex justify-around items-center h-16 z-50 px-4">
<button class="flex flex-col items-center gap-1 text-on-surface-variant">
<span class="material-symbols-outlined text-lg" data-icon="dashboard">dashboard</span>
<span class="text-[9px] uppercase font-bold tracking-tighter">Home</span>
</button>
<button class="flex flex-col items-center gap-1 text-on-surface-variant">
<span class="material-symbols-outlined text-lg" data-icon="grid_view">grid_view</span>
<span class="text-[9px] uppercase font-bold tracking-tighter">Gallery</span>
</button>
<button class="flex flex-col items-center gap-1 text-primary">
<span class="material-symbols-outlined text-lg" data-icon="emoji_events" style="font-variation-settings: 'FILL' 1;">emoji_events</span>
<span class="text-[9px] uppercase font-bold tracking-tighter">Tournament</span>
</button>
<button class="flex flex-col items-center gap-1 text-on-surface-variant">
<span class="material-symbols-outlined text-lg" data-icon="settings">settings</span>
<span class="text-[9px] uppercase font-bold tracking-tighter">Settings</span>
</button>
</nav>
</body></html>