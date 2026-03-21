<!DOCTYPE html>

<html class="dark" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Export &amp; Summary | The Digital Darkroom</title>
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
      body {
        font-family: 'Inter', sans-serif;
        background-color: #131313;
        color: #e5e2e1;
      }
      h1, h2, h3 {
        font-family: 'Manrope', sans-serif;
      }
      ::-webkit-scrollbar {
        width: 6px;
      }
      ::-webkit-scrollbar-track {
        background: #131313;
      }
      ::-webkit-scrollbar-thumb {
        background: #353534;
        border-radius: 10px;
      }
    </style>
</head>
<body class="bg-surface text-on-surface">
<!-- Top Navigation Bar -->
<nav class="bg-[#131313] dark:bg-zinc-950 flex justify-between items-center w-full px-6 h-16 fixed top-0 z-50">
<div class="flex items-center gap-8">
<span class="text-xl font-extrabold tracking-tighter text-[#E5E2E1] dark:text-[#E5E2E1]">The Digital Darkroom</span>
<div class="hidden md:flex gap-6 items-center">
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors font-['Manrope'] font-bold text-sm tracking-wide" href="#">Dashboard</a>
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors font-['Manrope'] font-bold text-sm tracking-wide" href="#">Gallery</a>
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors font-['Manrope'] font-bold text-sm tracking-wide" href="#">Compare</a>
<a class="text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors font-['Manrope'] font-bold text-sm tracking-wide" href="#">Tournament</a>
<a class="text-[#7BD0FF] border-b-2 border-[#7BD0FF] pb-1 font-['Manrope'] font-bold text-sm tracking-wide" href="#">Export</a>
</div>
</div>
<div class="flex items-center gap-4">
<button class="p-2 hover:bg-zinc-800/50 transition-all duration-200 rounded-full">
<span class="material-symbols-outlined text-on-surface-variant">settings</span>
</button>
<button class="p-2 hover:bg-zinc-800/50 transition-all duration-200 rounded-full">
<span class="material-symbols-outlined text-on-surface-variant">account_circle</span>
</button>
</div>
</nav>
<!-- Side Navigation Bar -->
<aside class="bg-[#1C1B1B] dark:bg-zinc-900 fixed left-0 top-0 h-full flex flex-col py-8 px-4 w-64 pt-24 shadow-2xl shadow-black/50 z-40 hidden md:flex">
<div class="mb-8 px-2">
<h3 class="text-lg font-bold text-[#E5E2E1]">Project Alpha</h3>
<p class="text-xs font-medium text-on-surface-variant uppercase tracking-widest mt-1">25 of 300 selected</p>
<div class="mt-4 flex items-center gap-2 px-3 py-2 bg-secondary-container/20 rounded-lg">
<span class="material-symbols-outlined text-primary text-sm" style="font-variation-settings: 'FILL' 1;">check_circle</span>
<span class="text-[10px] font-bold uppercase tracking-widest text-primary">Selection Finalized</span>
</div>
</div>
<nav class="flex-1 space-y-2">
<a class="flex items-center gap-3 px-4 py-3 text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] transition-all rounded-lg font-['Inter'] text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined">dashboard</span> Overview
            </a>
<a class="flex items-center gap-3 px-4 py-3 text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] transition-all rounded-lg font-['Inter'] text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined">grid_view</span> Selection
            </a>
<a class="flex items-center gap-3 px-4 py-3 text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] transition-all rounded-lg font-['Inter'] text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined">compare</span> Comparison
            </a>
<a class="flex items-center gap-3 px-4 py-3 text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] transition-all rounded-lg font-['Inter'] text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined">emoji_events</span> Tournament
            </a>
<a class="flex items-center gap-3 px-4 py-3 text-[#7BD0FF] bg-[#26467D]/20 border-r-4 border-[#7BD0FF] font-['Inter'] text-xs font-medium uppercase tracking-widest" href="#">
<span class="material-symbols-outlined">ios_share</span> Final Export
            </a>
</nav>
<button class="mt-auto w-full bg-gradient-to-r from-primary to-primary-container text-on-primary py-3 rounded-xl font-bold text-sm tracking-wide shadow-lg shadow-primary/20">
            Finalize Selection
        </button>
</aside>
<!-- Main Content Canvas -->
<main class="ml-0 md:ml-64 pt-24 pb-12 px-6 lg:px-12 max-w-[1440px]">
<header class="mb-10">
<h1 class="text-3xl font-extrabold tracking-tight text-on-surface mb-2">Export Summary</h1>
<p class="text-on-surface-variant max-w-2xl">Review your final selection of 25 assets. You can export the file manifest as a CSV or copy the list directly to your clipboard for post-production workflows.</p>
</header>
<div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
<!-- Left Column: Manifest List -->
<div class="lg:col-span-5 space-y-6">
<div class="bg-surface-container-low p-6 rounded-xl">
<div class="flex justify-between items-center mb-6">
<h2 class="text-sm font-bold uppercase tracking-widest text-on-surface-variant">File Manifest</h2>
<span class="text-xs bg-surface-container-highest px-2 py-1 rounded text-primary">25 FILES</span>
</div>
<div class="max-h-[600px] overflow-y-auto pr-2 space-y-1">
<!-- Simulated List of 25 files -->
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">IMG_2304.jpg</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">42.1 MB</span>
</div>
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">DSC_9981.raw</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">84.5 MB</span>
</div>
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">IMG_2305.jpg</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">38.9 MB</span>
</div>
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">DSC_9982.raw</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">79.2 MB</span>
</div>
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">FINAL_SHOT_01.raw</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">91.4 MB</span>
</div>
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">IMG_2310.jpg</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">41.2 MB</span>
</div>
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">DSC_9990.raw</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">88.7 MB</span>
</div>
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">STUDIO_A_04.jpg</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">35.1 MB</span>
</div>
<!-- ... repeated for effect ... -->
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">IMG_2315.raw</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">82.3 MB</span>
</div>
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">IMG_2316.raw</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">77.4 MB</span>
</div>
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">DSC_9995.jpg</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">36.9 MB</span>
</div>
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">IMG_2320.raw</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">85.0 MB</span>
</div>
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">STUDIO_A_12.raw</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">92.1 MB</span>
</div>
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">DSC_1002.jpg</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">40.5 MB</span>
</div>
<div class="group flex items-center justify-between p-3 rounded-lg hover:bg-surface-container-high transition-colors">
<span class="font-mono text-sm text-on-surface/80">IMG_2325.raw</span>
<span class="text-[10px] text-outline opacity-0 group-hover:opacity-100">81.8 MB</span>
</div>
</div>
</div>
<div class="flex flex-col gap-3">
<button class="w-full flex items-center justify-center gap-2 bg-gradient-to-br from-primary to-primary-container text-on-primary py-4 rounded-xl font-bold text-base transition-transform active:scale-95 shadow-xl shadow-primary/10">
<span class="material-symbols-outlined">download</span>
                        Export CSV Manifest
                    </button>
<button class="w-full flex items-center justify-center gap-2 bg-surface-container-highest hover:bg-surface-bright text-on-surface py-4 rounded-xl font-medium text-base transition-all border border-outline/10">
<span class="material-symbols-outlined">content_copy</span>
                        Copy List to Clipboard
                    </button>
</div>
</div>
<!-- Right Column: Visual Preview Grid -->
<div class="lg:col-span-7">
<div class="bg-surface-container-low p-6 rounded-xl h-full border border-outline/5">
<div class="flex justify-between items-center mb-6">
<h2 class="text-sm font-bold uppercase tracking-widest text-on-surface-variant">Visual Selection Preview</h2>
<div class="flex gap-2">
<span class="material-symbols-outlined text-on-surface-variant cursor-pointer hover:text-primary">zoom_in</span>
<span class="material-symbols-outlined text-on-surface-variant cursor-pointer hover:text-primary">grid_view</span>
</div>
</div>
<!-- 5x5 Grid for 25 photos -->
<div class="grid grid-cols-5 gap-3">
<!-- Repeat 25 tiny thumbnails -->
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Dark aesthetic landscape photography" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBIWq3PLlvf6552qKSXRBDs92-_TP_OVUBET_0ZcyT0tAlNac6D6Y-KolB8YT83Lzh-XAFYkJcyIHaNyvnIeUZ2zBIi8J5BXGXOv69p8mmPidt_gZkXmznR-k25TvbVCD9nMSfO140Cno4y8ok16WUCX5S7kA38bH6DEn5DzYJCoPS8r8pA4NTSqx0GtATHdI7lQoiCmGeNR-D2s3QzxwO8otA0w6HnObT-FFTW5rkpCWZDZpAuJihSptJ-xabKGWx280aUtOuQeUCr"/>
<div class="absolute inset-0 bg-primary/20 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
<span class="material-symbols-outlined text-white text-xs" style="font-variation-settings: 'FILL' 1;">check_circle</span>
</div>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Architectural minimal photography" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBoXLdiHa5Q-S5tQW3GzIYOyTX_fLc47oOCk1foWn8ZlputubSiw0Ww1vdk_zk5Lr95ro0y-o8zbck-hY039tUSf3_tu9wl9QxA-svm_J3214HuLyzQCSk_iQz910zBixV78Ihu4hbncCRlNH4gbPhKQv5Yfo0TI6eBCDvja7qzw6jsp9fnCZUt5iMvn9VX3lgVtlvJwiJs7LDgpX3m9Zh5Gl51pBFiLuE37juJYlxd7MxxDpWuP1dA6UrjZWJN4o7K4iTRN6fV3xgG"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Cinematic street scene at night" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAWqEyvk2CH-UkJeGI7Oilr9uNn2SjBjkSM1X9Hl89Ayt6ozkBEC4meaAlF2xaQTiC2JyHmwJDscUtHHYb68Wq7LmeBNJAFPUoHo6h_qSlxGbyFsVcPoWA8KLw31qfRs3G2upxfuY4r_1kcdVeCDjLS1GTBUNTJN-AV1SOzjnEepYziX6RVLsjK1g2EnOwhPX_ZAJrzzW4PmD-lUOqEJAWNoVJv1kW2nK-O4bk62aJOdGBkMn0WO7ivb4j-zVLuJOk7vJ3t-nRKHFq9"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Atmospheric mountain fog photography" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAw6vtWS4dmQEHbavL2Ppv7TfrFp3X5z_Sva5WWtKLV4yz8-4CWfTI6eM81bZdUg28LA8NZQeiPAwn9Q6fUP2jgjcq4Bo5TkJ33ZCCGmt7iqmogsFBAyVZ8zEI3T8JMH4YdDjgQWHKGxL4yMAFb4fLQ2GrqzJL7VcQXQzWSRSdZGrAofbaodouKRuAU_C6PTFJ4hvbGWV_p6Xr_1xEOgRQpfFIGkeath0p91U8FMCWAk9ZUsEYG0Y9Tc5-12_PK8W3nKl5MtbhmiQWM"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Close-up nebula astronomy shot" src="https://lh3.googleusercontent.com/aida-public/AB6AXuClYUlYck5cGi6Yo5YXxwdjgwRrHLcvGpCOToyYe-NLatgRgMpb0WN_EDo0rSFR7TkyyzxdHmk4gEb_cuKgujcNJaP5WFRDb8SAyVyjGjZJ38FAgXp51ZkcIj5fciNpAJIAxYoEyBhI3mPx0d5BlDRTft3aZ6Cqdes4L6yxlxyDpwOV45X3YSz6nArb_OWGt_EocdxDwbhAK2h24ly1jjDS8_QNXpAQyeiVGdxM1_KM3q9qniSghwX9yD4wmkWnbJhPwzVrODc0dXqc"/>
</div>
<!-- Row 2 -->
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Serene nature landscape" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCbGAEr6Ii2Cnz1z1K4RRsgJ2Gb7FkU0NiQOdx85--VU4TKXDJFBDIWebMeMhIRXxLR4x7CZWMch05Skys0aSNmOeRsHS03rfDw-afmpXFHVORYyYYTPTjVXIOESIsg2omm-J5lXXpoR_MbBFQXgCAnNflijqWGEfS-2NxW6TvayQYUEvMcldXCYoQIV9DmxSJWDahqwNb_0mJr9VxavpzXyOFxqxEMqtHVUtpsi_DdzSoL5z9sLwzkR3IJRssvVEFHUbxkS4SX-4PB"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Sharp mountain peaks" src="https://lh3.googleusercontent.com/aida-public/AB6AXuArm0qP9OTcBy0wo0myH81RZyNkhzZNhaezgCKsClVPsceXOL1Hwd2BOsW5Q9RfEuoneY4Nfm51ZUpA8tDYeVpU_i4DGiUAo_FhymtckyXmR-YaaNnRPABlsQirACaPoFeUKjW0lqcgg9oGr4BmY4nenBT1f4R9Xcnp19zUIRsd5Z18c6MS6F2LDmK2EiGa2fQOJ9dTSRrx4ZpF6gFxFryhumi4OWUEXmDNtL9rCL7Iwt5F5j6CPxSDWXvGVn7ofL2ghqZvkD0HccnX"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Green valley mist" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDy55ILUsttvKrd1liu4SpvvC84fYfCEGCD0n4R5dl0Utsuq_g6G1N1O8ymJTD7_njEAGxVkP1AEth8WaaWtFFGqLs780BgghVQp3Uj5QaXcEEYNxKZPSSacQEpzqlVE3Iyc9aGiNrU47VWKaq0j3KVD3BMNSLZatuOecvaGCzZS-KWAL2rPeMJqQKpYtQuCkJkHDuybZGeelCxRMHqqJaOE3rCBbYZiA7K9ubltOAtQbjl4vdYSM1qqFNCgNQKx9HaEujpQseRPH2R"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Deep forest sunbeams" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAplZEE23uaggyUmGDBJsGqi0rok579xD-UZRUOuXeEQId6TYdoQBlE6V5wkChjex8XmtVY3fTbfpr7Pfmc7tQBxLdWIKgIq8dEO84R_p3ZsqGFN-AbSxj6JvrUJWxsRzWQxtw1qolYX4u-QA89-YHZYWo4fzKWgWvGSWSqEBhTTC_iUeLCopW5dZaF9G16k_6eSvA5Lc354vb0UcwQzgHkQWf2-tANRHPz8OpB00j8dw9c_ccWqknkm5r6FdFGuwDr8bu8F98yIC5K"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Dynamic beach sunset" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDqSN-bmGkAbbnXbEy_LjK2HLh50qRedF9-uFj4AB0SN41blurKAJuPVuZyIMoi2QVBTnDKlaWWvDJ5cLWqh1glJHssXcKy2OjMD0J46KEn6iMTC1R4jfq5ipoEoOTTefx4exNPRPovi9jIjCazVM0nM_JkzdUEnUl0v2ZFboPt41YDCkI9hdYQCV3Zjaluztj5a2VCWl-lMDbcltbYbB8tIFnNyvvFR8g-OOSPDpRzPk3d5cfEqghMJQJQhmdbry8AA5ANivzRdAbY"/>
</div>
<!-- Row 3 -->
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Green hill panorama" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBaJzEpBMf-l8kfMPVhnjGT_6q_acR5kgPhJzo0UQdECshW9Cma12JoJCwU7SKEqJ751N6mDsytdVmgZBgmRyg9ixviOrp9jBdmxqvG5Ceqbol4E-L8YtoRQgX1vJIeX8MBYNq8IyxHZZWelLoJ14smJzXb5_x8QZEaRXIu6YNFjjZ1Y-CJsTEBf3EYYFAyI86wD8zOyXapeH2SvetQEYEln64q1Ouk05Hck9m0bHAUW6Uooe1e4tRBF1nz5TWPm1MNRc1izmmcUOZp"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Natural woodland trail" src="https://lh3.googleusercontent.com/aida-public/AB6AXuC2EkyQcXJparBZGvwUVSnxrX8T-htzIQzGp0Q7CW4SioJYRfvigMAOhTcCOYARR2CZKNA2taYXyYh1E0trU40fATpn0XlXTE8w58WmaoeW3_rb6FwDQNjxBPjGp8T1TGk5Vx44gpPpCXjCfBIZ2mG9Z4QhlSgxml_FeLw5HYtF47iS1Nd5moPZsy4tnIuW7Oi-OZCaWRcneq_7vsdk93yITdq1FmJcVZKQqEUtwKJTHqXX9CZ5fPpyYpxjXn7-eanxVcBA4QRgD5iU"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Hiker on mountain edge" src="https://lh3.googleusercontent.com/aida-public/AB6AXuA5XVQNx1IfR9xje5rSy4kh0gv9xIFgWcuAy4bE1UKdNZnn6r2dagTAJVQ-rjuLkPTgpXvvHi62d7gUemuu1S0N45rLWDiQPzu0E36CZJsEm_Kzf2g8irb9mdn6JftBYlxx9AEL5KvUsf5nAOWF57rgp0j60glF0ZNDRWuk8SzvB3eQZNOXxq_wZUvla9sM4VdU_fCgd6ZKmUmvT8g97TDMtDu4jlHvH8wCDGDu6zHZKUWC9UtNv4Cl3rneekn2IrChs-M5VDYKVNaR"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Flowing river long exposure" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBHhmGNMmRpIsCcSsjdhbfBunhD6ZSfPJjQHJ4b2DzmJ_NmOAkDPIU30bShPwRT_4MSQqXcxTaVq6OFQqk3PdDrF8WmxR4D62Cz0M6oF5bW1lupJkAugkWXrVqCAC7Hyv9B5wP2CM4dF5CezXMtEdn8y7dp254U3brr_mo3I1hrxzcQEgb6FxrxBoCak2GrHQ3pEyFctzbU8srHHe3doxglN__7T887oh7dgnxhCcGtrPdEs8jkiSAm7579vXEi76gz9SPaZEi1iOGm"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Wildlife in natural habitat" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCPR8-M1tqspg8p1phujdlfPP3DZltxdRDjYaSqrep7V_1HOYbp4pEO0yt4_Nt3tNqg1UVNItTSWB6nJJjUprSw-Cp0mhUhIk_Q2w54YcWgW1mLdGOwo5IJDi78HK5UyzVM7eCqto4IEZMM2G8LCeTrsgkfI-gBzwLe2tRZtY-FT_7Oki8LSsLlOdnHUePKYOFfZKmHfKLw33Q4Fhfkxuezavl7SdyHm95SfqquozNvY6eCIJMLLvcryaXbfwn0Sf7nfgDNpSSHSELn"/>
</div>
<!-- Row 4 -->
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Mountain lake reflection" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBTKW6-DWD8Xs6_0ZV8uzWfVa34byqT2_-Gw2B1iYXXDm8XyOACIUEBxLPjxXj006RjrshEwBRe9C7dDjw7tUGVAGB-mjP3riEtwtx17GzW5Q66e0n4RE3917a1XD35__HrLJxO2oZvhx7whP2jOxpSi8JKLia1WRvUcxLZroT1QlUIKbX8-ZKmz1xmJrSLbLkP3Svl4Lvzh9U2D7t00S8D8fetAjtehKujRAFuQBQcLX26N7_gW4sQqeXOx39abdY5DYgq5T84ItQg"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Satellite earth photography" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDZKzQj1tbdLtruH1i9QAv4lJrqGwYwHKBh8G1bpKGasKarKiecDRE_HA6obbuKdtPl4ohmTR6Zgo5xOFGH1Vx2jagKPkiK9Q4cFymOz392MHl7VKvseYm8m0vKMuoEARXAxXKRrw50qnKlz_o0LtnHIcfW9oXD7YazK4eHL2xhGJCtWIcpw6BoWESBsPO-y4stRJXdFm_KU0tTPOGUFTcTswQ-ud0rldFnFqkBuElyCH8O3TpmrMvWRDDxKeMs4GLanB8KDbeQIUBu"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Foggy forest morning" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBiUiYwPRDMYoI4lCJIiBEeSJi0SjgRktKwsa3CTW40AD3y8bmfRNarN2FW7vYwtyEjrLpVZwmZ7Av9LAEXQkFwGXXyRAxpnfi3JCmomiG5jgkgsPu-YWAMsqIk9SZMhKDT3jdmRKKtTeRFEvKAJD83FLqDUkTc2tlfNF3a6WQwBIrPxgov2mMnabwEOJPqBadRe9WC5w57iQBcFMq6s6CdzUYFuukzjwyuadscI57LXdV9Y4ENejQM5HitTTyUwuSkd-yUYbDG3R2v"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Blue lake alpine scene" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBVZvlEd20ECYojIA9z_dqsdX_g-J1DgGrOv6J1ee9Ccbt8OBI5m_N7wU2lcdqTNGefxClMy8iC9Nm4Np4_fw6V_Y30adL9AuYBU--ajMD2bTg_CaB2Dd1JyDNQF3fPOsuXiM2utic7XBZffNFKoLSDgr3dmUaABFg7D4G16ZGrY9m6ST8XB-5vA0j7MVygrYdP65pF3DJN5ij0wAw0ulHvb5l31_ho5DWRqBNH12jUvBLlyFPbSfhTakGxtN4_pNK3wUEJRIqfsLP2"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Boat on a calm lake" src="https://lh3.googleusercontent.com/aida-public/AB6AXuA6yx48P-mMEkRg5QxdjC6Q5Xc-fZAu76BSiAkMFV965ExjdlyAF9GJzNcJfV093y7pyHhdxHyOewDEfbtm96VC9vC40ghlP1NttUDdX3ahwQYET59NHMLLoP-oMUoFQZP5sXk-NS7uCYBZm9Ii7_567q3PRxDzGSRLSi5uM6vtI1UCf0tO6wVSWtEuB1xHq4jhQoNnO5XibHDd83rARKbzgWcTS3tVCk-wycbk9H9zXsbGyKCuu-4hezn9HF4QsGSKBmCNhiKaCo4H"/>
</div>
<!-- Row 5 -->
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Morning light in pine forest" src="https://lh3.googleusercontent.com/aida-public/AB6AXuALdF9SZ93fnDZVWOvYiThwyPGU9ZTWwv0LaVWFOoSWol7D0Kz5VSurKdJuDXlpBWn23LS4HK8XJ5DZqSYEsDzp6K7xa4-hTc3dQ0k55kO6aQMr6NaY2vavDVt858zp_lEhk-zP-RhSNe1vyFmuExWFX6Onv8-3_QWJrY773eiCtxoN4ISXyEZanxqhUbpc7fKxxuy0Ny3PmEPNxDvLbcs3NM_qaUtgp2S9XpE2Dc-yNHeLgaD4fpHZnZY0IuIQ9KjcNY0tyS4vv9eY"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Vintage road trip scene" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAtx1NbXDJxoPvQqqA36S-sDVAZ-mRDSBZmAgHrH--IK3d-VgD69vzYhdctIp94R-IvYjQonkhsZpMZcOA0NAMTOYezE4jrGGEVrUbSu1QmhGS5n2N5jO1ZyqrzG5MKSlYo69R0dvWa1UCGwynEECGgntbRkew7s46CxsmT4njQOJ28DM9L-ejIYoh2J36ktBmrmnAk_5vkpL5dXa7jKfy6qH2_KHN08weM3h84iy17ifWtU37lcOacN1_-BKbLJWEMobzahpi2j7V5"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Sunset field abstract" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAaM-WPUjEeFCkQnOSjX-2edAXgChiCtGD3nDDFefvDLFfR-F39yWXfaIH-RW7KAZ6I1r4ducG6JSIsYd0RdoUde2iq93cIsTeJ9dFoD6fbhWMCXOfUKemCwqL7_o235rKEq-n9tBmc2y5-Um6MoqW1nVPe1P3mhr4LaE04SG7B7v6eRlFy1aQHoRk6qOE_9JQGPzfr5kl4FyC1Pw50AO-uFruKcXdbEgwAst5EIXqqXbAtd1jQOVDS-C-Z8tmMj799BlYd9dlFX_mM"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative">
<img class="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500" data-alt="Yosemite valley landscape" src="https://lh3.googleusercontent.com/aida-public/AB6AXuB3i5psNtC0ZKFa2UhnEkgXocw-8kTg6UzUrk_dV7gbyAPYhVmwDauZyeQ_5CD5FCbR5S6FzZctOZYVJIVV4oeymZRtqIFtdhO7ZtZA4UJ59FyiRKaDcRAFbrmd5-AJ3Xaa3L2Ip0qRcLN4zSGBXd0bXxTXEP0Oh9QVQn4vkKkrnQN2B13QUJ6S3efBJKRScwaAwuuoJ3Comu_aJa2maVhZTZowGSYpzMKFlknZDfqcgJP7kU0c6TZ-YSvg9mQLB5enQhWBvVNigvHf"/>
</div>
<div class="aspect-square bg-surface-container-highest rounded-lg overflow-hidden group relative border-2 border-primary">
<img class="w-full h-full object-cover group-hover:brightness-110 transition-all duration-500" data-alt="Final selected landscape" src="https://lh3.googleusercontent.com/aida-public/AB6AXuC5CIBJmQIJiMG5AGkb0XV6u3uj-OL8zG3fxGqkrvkGsv2NsxgzxcyWmMaexMpC02O0QKIl9-6oIVyMqkiKkdCgqytnY5yEmDwLpEvsan9WIyQ5-JAVR9CnR0M9lh47YCf2-7cyglAkatujBnifkCBYAkN2Gwqjw7g1Mf3vvivJSuH2iC3VSw4TBepUABN_fHAqaacmCeBH5z5aaF9nO_rWeLgWmGVTUvSF2SY2jZiNcoUoXMmhIBMuwLXlY24WCWn7sYZ9f8_qBkt0"/>
<div class="absolute top-1 right-1">
<span class="material-symbols-outlined text-primary text-[14px]" style="font-variation-settings: 'FILL' 1;">star</span>
</div>
</div>
</div>
<!-- Project Metadata HUD -->
<div class="mt-10 pt-8 border-t border-outline/10 grid grid-cols-2 gap-4">
<div class="bg-surface-container-highest/40 p-4 rounded-lg">
<p class="text-[10px] font-bold uppercase tracking-widest text-on-surface-variant mb-2">Total Project Weight</p>
<p class="text-xl font-headline font-bold text-on-surface">1.84 GB</p>
</div>
<div class="bg-surface-container-highest/40 p-4 rounded-lg">
<p class="text-[10px] font-bold uppercase tracking-widest text-on-surface-variant mb-2">Export Format</p>
<p class="text-xl font-headline font-bold text-on-surface">Original RAW</p>
</div>
</div>
</div>
</div>
</div>
</main>
<!-- Success Feedback Overlay (Hidden by Default) -->
<div class="fixed bottom-8 right-8 bg-surface-container-highest text-on-surface px-6 py-4 rounded-xl shadow-2xl border border-primary/20 flex items-center gap-3 opacity-0 translate-y-4 transition-all pointer-events-none" id="export-toast">
<span class="material-symbols-outlined text-primary">check_circle</span>
<span class="text-sm font-medium">Manifest copied to clipboard</span>
</div>
</body></html>