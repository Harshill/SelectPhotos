<!DOCTYPE html>

<html class="dark" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Selection Gallery - The Digital Darkroom</title>
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
                    borderRadius: { "DEFAULT": "0.125rem", "lg": "0.25rem", "xl": "0.5rem", "full": "0.75rem" },
                },
            },
        }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            display: inline-block;
            line-height: 1;
            text-transform: none;
            letter-spacing: normal;
            word-wrap: normal;
            white-space: nowrap;
            direction: ltr;
        }
        .hide-scrollbar::-webkit-scrollbar { display: none; }
        .hide-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
        .photo-card-gradient {
            background: linear-gradient(to bottom, transparent 60%, rgba(19, 19, 19, 0.8) 100%);
        }
    </style>
</head>
<body class="bg-surface font-body text-on-surface select-none overflow-hidden">
<!-- Top Navigation Bar -->
<header class="bg-[#131313] dark:bg-zinc-950 flex justify-between items-center w-full px-6 h-16 docked full-width top-0 z-50">
<div class="flex items-center gap-8">
<span class="text-xl font-extrabold tracking-tighter text-[#E5E2E1] dark:text-[#E5E2E1] font-headline">The Digital Darkroom</span>
<nav class="hidden md:flex gap-6 font-['Manrope'] font-bold text-sm tracking-wide">
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Dashboard</a>
<a class="text-[#7BD0FF] border-b-2 border-[#7BD0FF] pb-1" href="#">Gallery</a>
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Compare</a>
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Tournament</a>
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors" href="#">Export</a>
</nav>
</div>
<div class="flex items-center gap-4">
<div class="relative hidden lg:block">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline text-sm">search</span>
<input class="bg-surface-container-low border-none rounded-lg py-1.5 pl-10 pr-4 text-xs w-64 focus:ring-1 focus:ring-primary text-on-surface-variant placeholder:text-outline" placeholder="Search metadata..." type="text"/>
</div>
<button class="p-2 hover:bg-zinc-800/50 transition-all duration-200 text-[#C1C6D7] rounded-lg">
<span class="material-symbols-outlined">settings</span>
</button>
<button class="p-2 hover:bg-zinc-800/50 transition-all duration-200 text-[#C1C6D7] rounded-lg">
<span class="material-symbols-outlined">account_circle</span>
</button>
</div>
</header>
<div class="flex h-[calc(100vh-4rem)]">
<!-- Sidebar Navigation (Active: Selection) -->
<aside class="fixed left-0 top-16 h-[calc(100vh-4rem)] w-64 bg-[#1C1B1B] dark:bg-zinc-900 shadow-2xl shadow-black/50 flex flex-col py-8 px-4 z-40">
<div class="mb-10 px-2">
<h2 class="text-lg font-bold text-[#E5E2E1] font-headline mb-1">Project Alpha</h2>
<p class="font-['Inter'] text-xs font-medium uppercase tracking-widest text-[#7BD0FF]">50 of 300 selected</p>
<div class="mt-4 h-1.5 w-full bg-surface-container-highest rounded-full overflow-hidden">
<div class="h-full bg-primary w-1/6"></div>
</div>
</div>
<nav class="space-y-1 flex-1">
<a class="flex items-center gap-3 px-4 py-3 text-[#C1C6D7] opacity-70 hover:opacity-100 font-['Inter'] text-xs font-medium uppercase tracking-widest transition-all hover:bg-[#353534] rounded-lg" href="#">
<span class="material-symbols-outlined text-lg">dashboard</span>
<span>Overview</span>
</a>
<a class="flex items-center gap-3 px-4 py-3 text-[#7BD0FF] bg-[#26467D]/20 border-r-4 border-[#7BD0FF] font-['Inter'] text-xs font-medium uppercase tracking-widest transition-all" href="#">
<span class="material-symbols-outlined text-lg" style="font-variation-settings: 'FILL' 1;">grid_view</span>
<span>Selection</span>
</a>
<a class="flex items-center gap-3 px-4 py-3 text-[#C1C6D7] opacity-70 hover:opacity-100 font-['Inter'] text-xs font-medium uppercase tracking-widest transition-all hover:bg-[#353534] rounded-lg" href="#">
<span class="material-symbols-outlined text-lg">compare</span>
<span>Comparison</span>
</a>
<a class="flex items-center gap-3 px-4 py-3 text-[#C1C6D7] opacity-70 hover:opacity-100 font-['Inter'] text-xs font-medium uppercase tracking-widest transition-all hover:bg-[#353534] rounded-lg" href="#">
<span class="material-symbols-outlined text-lg">emoji_events</span>
<span>Tournament</span>
</a>
<a class="flex items-center gap-3 px-4 py-3 text-[#C1C6D7] opacity-70 hover:opacity-100 font-['Inter'] text-xs font-medium uppercase tracking-widest transition-all hover:bg-[#353534] rounded-lg" href="#">
<span class="material-symbols-outlined text-lg">ios_share</span>
<span>Final Export</span>
</a>
</nav>
<div class="mt-auto px-2">
<button class="w-full bg-gradient-to-r from-primary to-primary-container text-on-primary font-bold py-3 rounded-lg text-sm shadow-lg hover:brightness-110 active:scale-95 transition-all">
                    Finalize Selection
                </button>
</div>
</aside>
<!-- Main Content Area -->
<main class="ml-64 flex-1 overflow-y-auto bg-surface p-6 hide-scrollbar">
<!-- Toolbar -->
<div class="flex items-center justify-between mb-8">
<div class="flex items-center gap-4">
<h1 class="text-2xl font-extrabold font-headline tracking-tight text-on-surface">Gallery</h1>
<div class="flex gap-2">
<span class="px-3 py-1 rounded-full bg-surface-container-high text-on-surface-variant text-[10px] font-bold uppercase tracking-wider">All Assets</span>
<span class="px-3 py-1 rounded-full bg-secondary-container text-on-secondary-container text-[10px] font-bold uppercase tracking-wider">Potential (50)</span>
</div>
</div>
<div class="flex items-center gap-3">
<button class="flex items-center gap-2 px-3 py-2 bg-surface-container-low hover:bg-surface-bright transition-colors rounded-lg text-xs font-medium">
<span class="material-symbols-outlined text-sm">filter_list</span>
                        Filter
                    </button>
<button class="flex items-center gap-2 px-3 py-2 bg-surface-container-low hover:bg-surface-bright transition-colors rounded-lg text-xs font-medium">
<span class="material-symbols-outlined text-sm">sort</span>
                        Sort
                    </button>
</div>
</div>
<!-- Bento/Dense Grid Layout -->
<div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 xl:grid-cols-5 2xl:grid-cols-6 gap-4">
<!-- Repeatable Photo Card Unit -->
<!-- Card 1 (Selected/Seed State) -->
<div class="group relative aspect-[4/5] rounded-lg overflow-hidden bg-surface-container-high ring-2 ring-primary">
<img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" data-alt="Close up dramatic architectural photography with deep shadows" src="https://lh3.googleusercontent.com/aida-public/AB6AXuB6UdQd_6gydMY7RrNsNJnHRbAXrTDFY474O4_JGrDtz0lLtkvCVq3Vy6ZVmyXwPYfpHa1rUbsPUszf3ubk-WdcxkDE9jOE60XU5Ad_F881gzeeXfxOcO-HbsWSMaCe0PZ3t4wHyLGLJ1AfiW618N6KE-AWUN6vXl-9r1FcDldlhHtaSSxVgJFWM5UOrp1fFQlzaYS7gXQ-3ZpmiDilu6hfdPw3Y36mqoBAZ2sfRXmQv_LgjnkJz67oayE4_bFicMB5_QigfHkeQmkp"/>
<div class="absolute inset-0 photo-card-gradient opacity-0 group-hover:opacity-100 transition-opacity flex flex-col justify-end p-3">
<div class="flex justify-between items-center">
<div class="flex gap-2">
<button class="w-8 h-8 rounded-full bg-surface-container-highest/80 backdrop-blur-md flex items-center justify-center text-error hover:bg-error hover:text-on-error transition-all">
<span class="material-symbols-outlined text-lg">close</span>
</button>
<button class="w-8 h-8 rounded-full bg-primary/80 backdrop-blur-md flex items-center justify-center text-on-primary transition-all">
<span class="material-symbols-outlined text-lg" style="font-variation-settings: 'FILL' 1;">favorite</span>
</button>
</div>
<span class="text-[10px] font-mono text-on-surface/60">IMG_2931.RAW</span>
</div>
</div>
<div class="absolute top-2 right-2 bg-primary/20 backdrop-blur-md border border-primary/30 p-1 rounded">
<span class="material-symbols-outlined text-primary text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
</div>
</div>
<!-- Repeat for high density (Visual simulation of 300) -->
<div class="group relative aspect-[4/5] rounded-lg overflow-hidden bg-surface-container-high">
<img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" data-alt="Eiffel Tower at night with golden lights" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBtb9GS9ysChzuk7AFaREedA5qU_bKBHTI0N3Wq7VHkjynZQKXtJEEwqM6PsOOLI1PZU7wDQ__NoRtTjZLLZldoA7UER2cdP_Rqbu0MFOg_uo08f02gKguTdAqCrQV2FEwCdqZjkH7zC4XLsdrRfPJCBesGM0FU85hn0CBWsEyWpvl5Qzl-VEueN65t4GeM1BtNcnr8TFLK1jO1HBxQC0-t45MlyX8w5aKaQK2n8SF24P5sWl6CcS7yYmxFzLEhkPuZTYf0Ix96cwWV"/>
<div class="absolute inset-0 photo-card-gradient opacity-0 group-hover:opacity-100 transition-opacity flex flex-col justify-end p-3">
<div class="flex justify-between items-center">
<div class="flex gap-2">
<button class="w-8 h-8 rounded-full bg-surface-container-highest/80 backdrop-blur-md flex items-center justify-center text-on-surface hover:bg-error hover:text-on-error transition-all">
<span class="material-symbols-outlined text-lg">close</span>
</button>
<button class="w-8 h-8 rounded-full bg-surface-container-highest/80 backdrop-blur-md flex items-center justify-center text-on-surface hover:bg-primary hover:text-on-primary transition-all">
<span class="material-symbols-outlined text-lg">favorite</span>
</button>
</div>
<span class="text-[10px] font-mono text-on-surface/60">IMG_2932.RAW</span>
</div>
</div>
</div>
<div class="group relative aspect-[4/5] rounded-lg overflow-hidden bg-surface-container-high">
<img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" data-alt="Professional camera lens detail in dark studio" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAWKHge2HHDoevLSuUxRStUqTZzcv9fZ8oCmHyAzHZPwxRBiag6kvntuik0xqmhJ1tMr3hNZsJ7wQ323nSzdqhzyaAtr7f7qfIUtZFULmMGdldZ-YPUNWr3n4B7eNMGcYbjSwQShLE4v4D4RCusIr0n-S5U-9c4pOCjl0Pk2Q4PCNgL8gmU2gZ3DZIJnBLYkCCv0gfTbGu0jf8xInArfOzaKrDq43keHlObN3_iEo3SJ8B0LMq9AiVFx28BXtsYWdNzoUi8cudn9-jW"/>
<div class="absolute inset-0 photo-card-gradient opacity-0 group-hover:opacity-100 transition-opacity flex flex-col justify-end p-3">
<div class="flex justify-between items-center">
<div class="flex gap-2">
<button class="w-8 h-8 rounded-full bg-surface-container-highest/80 backdrop-blur-md flex items-center justify-center text-on-surface hover:bg-error hover:text-on-error transition-all">
<span class="material-symbols-outlined text-lg">close</span>
</button>
<button class="w-8 h-8 rounded-full bg-surface-container-highest/80 backdrop-blur-md flex items-center justify-center text-on-surface hover:bg-primary hover:text-on-primary transition-all">
<span class="material-symbols-outlined text-lg">favorite</span>
</button>
</div>
<span class="text-[10px] font-mono text-on-surface/60">IMG_2933.RAW</span>
</div>
</div>
</div>
<div class="group relative aspect-[4/5] rounded-lg overflow-hidden bg-surface-container-high grayscale hover:grayscale-0 transition-all">
<img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" data-alt="Mountain landscape with dramatic clouds and fog" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDudUs9875MmsUlhnJ-uAtrQwoBHY6FDUI6qnAtfWSiw6b4H9lfJ3ut2TmY9pXT6zZ5B_H-Z5e0cIJ0eKA-yY4_1uDGydGGPXf26ocxiTNrA_E205IMMAMDEFZOpZE9d12fsftmdx0uPbtoBQn-zVBwSrDHdGJ5MVZtC_K1HXu-4JzjrO_FrFIcpwKNkXJhGAQfTK3w2PPR88QRQS1ggT0Tau5GT88bQOCm1sfvbR6dZRIfY7G0_s18kE_2WGvCh2RPKK319-nHeiIG"/>
<div class="absolute inset-0 photo-card-gradient opacity-0 group-hover:opacity-100 transition-opacity flex flex-col justify-end p-3">
<div class="flex justify-between items-center">
<div class="flex gap-2">
<button class="w-8 h-8 rounded-full bg-surface-container-highest/80 backdrop-blur-md flex items-center justify-center text-on-surface hover:bg-error hover:text-on-error transition-all">
<span class="material-symbols-outlined text-lg">close</span>
</button>
<button class="w-8 h-8 rounded-full bg-surface-container-highest/80 backdrop-blur-md flex items-center justify-center text-on-surface hover:bg-primary hover:text-on-primary transition-all">
<span class="material-symbols-outlined text-lg">favorite</span>
</button>
</div>
<span class="text-[10px] font-mono text-on-surface/60">IMG_2934.RAW</span>
</div>
</div>
</div>
<div class="group relative aspect-[4/5] rounded-lg overflow-hidden bg-surface-container-high">
<img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" data-alt="Vintage camera on a dark wooden table" src="https://lh3.googleusercontent.com/aida-public/AB6AXuB2N4Tyld_HrkvzLSE3TfaQK7rXnX7lmrEDQj62LY0jUY1D-cMEaXgoVGKyBC615PCawTzh2fuzKHeG5MLZRHMtvnTtnlKS9VlRG6VxN0XL-7l80FU88qEa7O-7EBwELfKnyRFtswQgmY6grboy9fxOM4BqEpMw49CLb1luDMExpvg5sMiiosh6yWkJ7lPmntBAp3Gb5iRlmOCefeXVoASB1qOske8nYlLQHQt4rDuHoWajbR1Kd9w_3u1O9AWiRmyP5PGVdrMuMBdM"/>
<div class="absolute inset-0 photo-card-gradient opacity-0 group-hover:opacity-100 transition-opacity flex flex-col justify-end p-3">
<div class="flex justify-between items-center">
<div class="flex gap-2">
<button class="w-8 h-8 rounded-full bg-surface-container-highest/80 backdrop-blur-md flex items-center justify-center text-on-surface hover:bg-error hover:text-on-error transition-all">
<span class="material-symbols-outlined text-lg">close</span>
</button>
<button class="w-8 h-8 rounded-full bg-surface-container-highest/80 backdrop-blur-md flex items-center justify-center text-on-surface hover:bg-primary hover:text-on-primary transition-all">
<span class="material-symbols-outlined text-lg">favorite</span>
</button>
</div>
<span class="text-[10px] font-mono text-on-surface/60">IMG_2935.RAW</span>
</div>
</div>
</div>
<div class="group relative aspect-[4/5] rounded-lg overflow-hidden bg-surface-container-high opacity-40">
<img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" data-alt="Close up portrait of a man with dramatic lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBLUaDGW1E64jF3NDUZ53T6ddDW4ZR0p-wLQbQdKWQuDztYYixKWrBrE6hEjsWWR0Z4e7dQwur83kd3XVgltK3jlFrQV8lUxfXqVWXVkrodanKYfsvJaFrLtS-fvXMI_XEcwiQpot7Htfll-OQCF8OwoUoYxOchvSc_K5nN-yTVqvDkK19zckZ1Y1Bzkm0gEZKxSJ26luyZsF-cEuvQZzFMA3L5tUcdcu6Drb7oye3CX72SQLUNbFg-xWNTccE_VbxJkuzXD5w-bkFh"/>
<div class="absolute inset-0 photo-card-gradient flex flex-col justify-end p-3">
<div class="flex justify-between items-center">
<div class="flex gap-2">
<button class="w-8 h-8 rounded-full bg-error/80 backdrop-blur-md flex items-center justify-center text-on-error">
<span class="material-symbols-outlined text-lg">close</span>
</button>
<button class="w-8 h-8 rounded-full bg-surface-container-highest/80 backdrop-blur-md flex items-center justify-center text-on-surface">
<span class="material-symbols-outlined text-lg">favorite</span>
</button>
</div>
<span class="text-[10px] font-mono text-on-surface/60 uppercase">Rejected</span>
</div>
</div>
</div>
<!-- Bulk Fill Grid for Density Simulation -->
<script>
                    const container = document.querySelector('.grid');
                    const images = [
                        'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?q=80&w=1000&auto=format&fit=crop',
                        'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=1000&auto=format&fit=crop',
                        'https://images.unsplash.com/photo-1501785888041-af3ef285b470?q=80&w=1000&auto=format&fit=crop',
                        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?q=80&w=1000&auto=format&fit=crop'
                    ];
                    
                    for (let i = 0; i < 24; i++) {
                        const div = document.createElement('div');
                        div.className = "group relative aspect-[4/5] rounded-lg overflow-hidden bg-surface-container-high";
                        const imgIdx = i % images.length;
                        div.innerHTML = `
                            <img src="${images[imgIdx]}" data-alt="Nature landscape photography" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110">
                            <div class="absolute inset-0 photo-card-gradient opacity-0 group-hover:opacity-100 transition-opacity flex flex-col justify-end p-3">
                                <div class="flex justify-between items-center">
                                    <div class="flex gap-2">
                                        <button class="w-8 h-8 rounded-full bg-surface-container-highest/80 backdrop-blur-md flex items-center justify-center text-on-surface hover:bg-error hover:text-on-error transition-all">
                                            <span class="material-symbols-outlined text-lg">close</span>
                                        </button>
                                        <button class="w-8 h-8 rounded-full bg-surface-container-highest/80 backdrop-blur-md flex items-center justify-center text-on-surface hover:bg-primary hover:text-on-primary transition-all">
                                            <span class="material-symbols-outlined text-lg">favorite</span>
                                        </button>
                                    </div>
                                    <span class="text-[10px] font-mono text-on-surface/60">IMG_294${i}.RAW</span>
                                </div>
                            </div>
                        `;
                        container.appendChild(div);
                    }
                </script>
</div>
</main>
<!-- Contextual Metadata HUD (Floating) -->
<div class="fixed bottom-6 right-6 w-80 bg-surface-container-highest/80 backdrop-blur-xl p-4 rounded-xl border border-outline/10 shadow-[0_20px_50px_rgba(0,0,0,0.5)] z-50">
<div class="flex justify-between items-start mb-4">
<div>
<h3 class="font-headline font-bold text-sm text-on-surface">Selected Asset</h3>
<p class="text-[10px] font-mono text-outline uppercase tracking-widest">Metadata Inspector</p>
</div>
<span class="px-2 py-0.5 bg-primary/20 text-primary text-[9px] font-bold rounded">RAW</span>
</div>
<div class="grid grid-cols-2 gap-4">
<div class="bg-surface-container-low p-2 rounded-lg">
<p class="text-[9px] text-outline uppercase font-bold mb-1">Exposure</p>
<p class="text-xs font-mono">1/250s at f/2.8</p>
</div>
<div class="bg-surface-container-low p-2 rounded-lg">
<p class="text-[9px] text-outline uppercase font-bold mb-1">ISO Speed</p>
<p class="text-xs font-mono">ISO 100</p>
</div>
<div class="bg-surface-container-low p-2 rounded-lg">
<p class="text-[9px] text-outline uppercase font-bold mb-1">Focal Length</p>
<p class="text-xs font-mono">85mm Prime</p>
</div>
<div class="bg-surface-container-low p-2 rounded-lg">
<p class="text-[9px] text-outline uppercase font-bold mb-1">Color Space</p>
<p class="text-xs font-mono">Adobe RGB</p>
</div>
</div>
<button class="w-full mt-4 flex items-center justify-center gap-2 py-2 border border-primary/30 text-primary hover:bg-primary/10 rounded-lg text-xs font-bold transition-all">
<span class="material-symbols-outlined text-sm">compare</span>
                Open Comparison View
            </button>
</div>
</div>
</body></html>