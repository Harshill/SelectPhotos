defmodule SelectPhotosWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use SelectPhotosWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  attr :active_page, :atom, default: :dashboard, doc: "the currently active page"
  attr :selected_count, :integer, default: 0, doc: "number of selected photos"
  attr :total_count, :integer, default: 0, doc: "total number of photos"

  slot :inner_block, required: true

  def app(assigns) do
    nav_items = [
      %{page: :dashboard, label: "Dashboard", href: "/", icon: "dashboard"},
      %{page: :gallery, label: "Gallery", href: "/gallery", icon: "grid_view"},
      %{page: :compare, label: "Compare", href: "/compare", icon: "compare"},
      %{page: :tournament, label: "Tournament", href: "/tournament", icon: "emoji_events"},
      %{page: :export, label: "Export", href: "/export", icon: "ios_share"}
    ]

    sidebar_items = [
      %{page: :dashboard, label: "Overview", href: "/", icon: "dashboard"},
      %{page: :gallery, label: "Selection", href: "/gallery", icon: "grid_view"},
      %{page: :compare, label: "Comparison", href: "/compare", icon: "compare"},
      %{page: :tournament, label: "Tournament", href: "/tournament", icon: "emoji_events"},
      %{page: :export, label: "Final Export", href: "/export", icon: "ios_share"}
    ]

    assigns = assign(assigns, :nav_items, nav_items)
    assigns = assign(assigns, :sidebar_items, sidebar_items)

    ~H"""
    <%!-- Top Navigation Bar --%>
    <header class="bg-[#131313] flex justify-between items-center w-full px-6 h-16 z-50 border-b border-[#414755]/10">
      <div class="flex items-center gap-8">
        <a href="/" class="text-xl font-extrabold tracking-tighter text-[#E5E2E1] font-['Manrope']">
          The Digital Darkroom
        </a>
        <nav class="hidden md:flex items-center gap-6 font-['Manrope'] font-bold text-sm tracking-wide">
          <%= for item <- @nav_items do %>
            <a
              href={item.href}
              class={if item.page == @active_page,
                do: "text-[#7BD0FF] border-b-2 border-[#7BD0FF] pb-1",
                else: "text-[#C1C6D7] hover:text-[#E5E2E1] transition-colors"}
            >
              {item.label}
            </a>
          <% end %>
        </nav>
      </div>
      <div class="flex items-center gap-4">
        <button class="p-2 text-[#C1C6D7] hover:bg-zinc-800/50 transition-all duration-200 rounded-full">
          <span class="material-symbols-outlined">settings</span>
        </button>
        <button class="p-2 text-[#C1C6D7] hover:bg-zinc-800/50 transition-all duration-200 rounded-full">
          <span class="material-symbols-outlined">account_circle</span>
        </button>
      </div>
    </header>

    <div class="flex h-[calc(100vh-64px)]">
      <%!-- Sidebar Navigation --%>
      <aside class="bg-[#1C1B1B] w-64 flex-shrink-0 flex-col py-8 px-4 shadow-2xl shadow-black/50 z-40 hidden md:flex">
        <div class="mb-8 px-2">
          <h2 class="text-lg font-bold text-[#E5E2E1] font-['Manrope'] mb-1">Project</h2>
          <p class="font-['Inter'] text-xs font-medium uppercase tracking-widest text-[#7BD0FF]">
            {@selected_count} of {@total_count} selected
          </p>
          <%= if @total_count > 0 do %>
            <div class="mt-4 h-1.5 w-full bg-[#353534] rounded-full overflow-hidden">
              <div
                class="h-full selection-gradient transition-all duration-500"
                style={"width: #{min(trunc(@selected_count / max(@total_count, 1) * 100), 100)}%"}
              >
              </div>
            </div>
          <% end %>
        </div>

        <nav class="flex-1 space-y-1">
          <%= for item <- @sidebar_items do %>
            <a
              href={item.href}
              class={if item.page == @active_page,
                do: "flex items-center gap-3 px-4 py-3 text-[#7BD0FF] bg-[#26467D]/20 border-r-4 border-[#7BD0FF] font-['Inter'] text-xs font-medium uppercase tracking-widest transition-all",
                else: "flex items-center gap-3 px-4 py-3 text-[#C1C6D7] opacity-70 hover:opacity-100 hover:bg-[#353534] font-['Inter'] text-xs font-medium uppercase tracking-widest transition-all rounded-lg"}
            >
              <span class="material-symbols-outlined text-lg">{item.icon}</span>
              <span>{item.label}</span>
            </a>
          <% end %>
        </nav>

        <div class="mt-auto px-2">
          <a
            href="/export"
            class="block w-full selection-gradient text-[#003549] font-bold py-3 rounded-lg text-sm text-center shadow-lg hover:brightness-110 active:scale-95 transition-all"
          >
            Finalize Selection
          </a>
        </div>
      </aside>

      <%!-- Main Content Area --%>
      <main class="flex-1 overflow-hidden">
        {render_slot(@inner_block)}
      </main>
    </div>

    <.flash_group flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Provides dark vs light theme toggle based on themes defined in app.css.

  See <head> in root.html.heex which applies the theme before page load.
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="card relative flex flex-row items-center border-2 border-base-300 bg-base-300 rounded-full">
      <div class="absolute w-1/3 h-full rounded-full border-1 border-base-200 bg-base-100 brightness-200 left-0 [[data-theme=light]_&]:left-1/3 [[data-theme=dark]_&]:left-2/3 transition-[left]" />

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
      >
        <.icon name="hero-computer-desktop-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
      >
        <.icon name="hero-sun-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
      >
        <.icon name="hero-moon-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>
    </div>
    """
  end
end
