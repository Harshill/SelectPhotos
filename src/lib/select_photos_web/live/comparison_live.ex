defmodule SelectPhotosWeb.ComparisonLive do
  use SelectPhotosWeb, :live_view

  alias SelectPhotos.Gallery

  @impl true
  def mount(_params, _session, socket) do
    directory = Application.get_env(:select_photos, :photo_directory, "")
    groups = Gallery.list_alternate_groups(directory)

    socket =
      socket
      |> assign(:directory, directory)
      |> assign(:groups, groups)
      |> assign(:current_index, 0)
      |> assign(:page_title, "Compare")
      |> assign_current_group()

    {:ok, socket}
  end

  @impl true
  def handle_event("swap_primary", %{"id" => id}, socket) do
    group = socket.assigns.current_group
    photo = Gallery.get_photo!(id)
    {:ok, _promoted} = Gallery.swap_primary(group, photo)

    {:noreply, reload_current_group(socket)}
  end

  @impl true
  def handle_event("confirm_primary", _params, socket) do
    # The primary is confirmed — reject and remove all alternates
    group = Gallery.get_group_with_photos(socket.assigns.current_group.id)

    group.photos
    |> Enum.reject(& &1.is_primary)
    |> Enum.each(fn photo ->
      Gallery.reject_photo(photo)
      Gallery.remove_from_group(photo)
    end)

    # Also remove the primary from the group (it's now a standalone selected photo)
    primary = Enum.find(group.photos, & &1.is_primary)
    if primary, do: Gallery.remove_from_group_keep_status(primary)

    # Reload groups and stay at current index (which now points to the next group)
    {:noreply, reload_current_group(socket)}
  end

  @impl true
  def handle_event("reject_alternate", %{"id" => id}, socket) do
    photo = Gallery.get_photo!(id)
    {:ok, _} = Gallery.reject_photo(photo)
    {:ok, _} = Gallery.remove_from_group(photo)

    {:noreply, reload_current_group(socket)}
  end

  @impl true
  def handle_event("skip_group", _params, socket) do
    {:noreply, advance_group(socket)}
  end

  @impl true
  def handle_event("prev_group", _params, socket) do
    index = max(socket.assigns.current_index - 1, 0)
    {:noreply, socket |> assign(:current_index, index) |> assign_current_group()}
  end

  defp reload_current_group(socket) do
    directory = socket.assigns.directory
    groups = Gallery.list_alternate_groups(directory)
    # Clamp index in case groups shrunk
    index = min(socket.assigns.current_index, max(length(groups) - 1, 0))
    socket |> assign(:groups, groups) |> assign(:current_index, index) |> assign_current_group()
  end

  defp advance_group(socket) do
    directory = socket.assigns.directory
    groups = Gallery.list_alternate_groups(directory)
    next_index = min(socket.assigns.current_index + 1, max(length(groups) - 1, 0))

    socket
    |> assign(:groups, groups)
    |> assign(:current_index, next_index)
    |> assign_current_group()
  end

  defp assign_current_group(socket) do
    groups = socket.assigns.groups
    index = socket.assigns.current_index

    if groups == [] do
      socket
      |> assign(:current_group, nil)
      |> assign(:primary, nil)
      |> assign(:alternates, [])
    else
      index = min(index, length(groups) - 1)
      group = Enum.at(groups, index)

      primary = Enum.find(group.photos, & &1.is_primary)

      # If no primary exists (e.g. it was deselected), promote the first photo
      {primary, group} =
        if primary == nil and group.photos != [] do
          first = hd(group.photos)
          {:ok, promoted} = Gallery.swap_primary(group, first)
          group = Gallery.get_group_with_photos(group.id)
          {promoted, group}
        else
          {primary, group}
        end

      alternates = Enum.reject(group.photos, & &1.is_primary)

      socket
      |> assign(:current_index, index)
      |> assign(:current_group, group)
      |> assign(:primary, primary)
      |> assign(:alternates, alternates)
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} active_page={:compare} selected_count={length(Enum.filter(List.flatten(Enum.map(@groups, & &1.photos)), & &1.is_primary))} total_count={length(List.flatten(Enum.map(@groups, & &1.photos)))}>
      <div class="flex flex-col h-full overflow-hidden">
        <%= if @current_group == nil do %>
          <%!-- No groups to compare --%>
          <div class="flex items-center justify-center h-full text-[#8B90A0]">
            <div class="text-center">
              <span class="material-symbols-outlined text-5xl text-[#353534] mb-4 block">compare</span>
              <p class="text-lg font-['Manrope'] font-bold mb-2">No groups to compare</p>
              <p class="text-sm mb-4">Go to the Gallery and select photos with alternates first</p>
              <a
                href="/gallery"
                class="selection-gradient text-[#003549] px-6 py-2 rounded-lg text-xs font-bold uppercase tracking-widest inline-block"
              >
                Back to Gallery
              </a>
            </div>
          </div>
        <% else %>
          <%!-- Header --%>
          <div class="flex justify-between items-end px-6 py-4">
            <div>
              <h1 class="font-['Manrope'] font-extrabold text-2xl text-[#E5E2E1] tracking-tight">
                Image Refinement
              </h1>
              <p class="text-[#C1C6D7] text-sm">
                Set {@current_index + 1} of {length(@groups)}
              </p>
            </div>
            <div class="flex items-center gap-3">
              <div class="bg-[#2A2A2A] px-3 py-1.5 rounded-lg flex items-center gap-2 border border-[#414755]/10">
                <span class="w-2 h-2 rounded-full bg-[#7BD0FF] animate-pulse"></span>
                <span class="text-xs font-bold uppercase tracking-tighter text-[#C1C6D7]">Live Comparison</span>
              </div>
            </div>
          </div>

          <%!-- Comparison workspace (Asymmetric Layout) --%>
          <div class="flex-1 flex gap-6 p-6 pt-2 min-h-0 overflow-hidden">
            <%!-- Left: Primary photo (large) --%>
            <div class="flex-[3] relative group bg-[#1C1B1B] rounded-xl overflow-hidden shadow-2xl border border-[#414755]/5">
              <img
                src={"/photos/#{@primary.filename}"}
                alt={@primary.filename}
                class="w-full h-full object-contain"
              />
              <%!-- Floating HUD --%>
              <div class="absolute bottom-6 left-6 right-6 glass-panel p-4 rounded-xl border border-[#414755]/20 flex justify-between items-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                <div class="flex flex-col">
                  <span class="text-[#7BD0FF] font-['Manrope'] font-bold text-sm tracking-wide">
                    SEED CANDIDATE
                  </span>
                  <span class="text-[10px] text-[#C1C6D7] font-mono mt-1">
                    {@primary.filename}
                  </span>
                </div>
                <div class="flex gap-2">
                  <button class="p-2 bg-[#201F1F] rounded-lg text-[#E5E2E1] hover:bg-[#393939] transition-colors">
                    <span class="material-symbols-outlined">zoom_in</span>
                  </button>
                </div>
              </div>
              <%!-- Label --%>
              <div class="absolute top-6 left-6 bg-[#7BD0FF]/90 text-[#003549] px-3 py-1 rounded-full text-[10px] font-bold tracking-widest uppercase">
                Master View
              </div>
            </div>

            <%!-- Right: Alternates sidebar --%>
            <div class="flex-[1] flex flex-col gap-4 overflow-y-auto pr-2 custom-scrollbar">
              <%= if @alternates == [] do %>
                <div class="flex items-center justify-center h-full text-[#8B90A0] text-sm">
                  No alternates remaining
                </div>
              <% end %>
              <%= for alt <- @alternates do %>
                <div class="bg-[#2A2A2A] p-3 rounded-xl border border-[#414755]/10 group/alt">
                  <div class="relative aspect-video rounded-lg overflow-hidden mb-3">
                    <img
                      src={"/photos/#{alt.filename}"}
                      alt={alt.filename}
                      class="w-full h-full object-cover"
                    />
                    <%!-- Swap overlay --%>
                    <button
                      phx-click="swap_primary"
                      phx-value-id={alt.id}
                      class="absolute inset-0 bg-black/40 opacity-0 group-hover/alt:opacity-100 flex items-center justify-center transition-opacity"
                    >
                      <div class="bg-[#353534] px-4 py-2 rounded-full flex items-center gap-2 text-xs font-bold text-[#E5E2E1]">
                        <span class="material-symbols-outlined text-sm">swap_horiz</span> Swap Seed
                      </div>
                    </button>
                  </div>
                  <div class="flex justify-between items-center">
                    <div class="flex flex-col">
                      <span class="text-xs font-bold font-['Manrope'] text-[#E5E2E1]">Candidate</span>
                      <span class="text-[10px] text-[#C1C6D7] font-mono truncate">{alt.filename}</span>
                    </div>
                    <div class="flex gap-1.5">
                      <button
                        phx-click="swap_primary"
                        phx-value-id={alt.id}
                        class="bg-[#201F1F] text-[#E5E2E1] hover:text-[#7BD0FF] p-2 rounded-lg flex items-center justify-center hover:bg-[#393939] transition-all"
                        title="Swap with Master"
                      >
                        <span class="material-symbols-outlined text-base">swap_horiz</span>
                      </button>
                      <button
                        phx-click="reject_alternate"
                        phx-value-id={alt.id}
                        class="bg-[#201F1F] text-[#C1C6D7] hover:text-[#FFB4AB] p-2 rounded-lg flex items-center justify-center hover:bg-[#393939] transition-all"
                        title="Reject"
                      >
                        <span class="material-symbols-outlined text-base">close</span>
                      </button>
                    </div>
                  </div>
                </div>
              <% end %>
            </div>
          </div>

          <%!-- Footer Toolbar --%>
          <footer class="bg-[#1C1B1B] h-14 mx-6 mb-4 rounded-xl flex items-center px-6 justify-between border border-[#414755]/5">
            <div class="flex items-center gap-4">
              <button
                phx-click="prev_group"
                disabled={@current_index == 0}
                class={"text-[#C1C6D7] hover:text-[#7BD0FF] flex items-center gap-2 transition-colors " <> if(@current_index == 0, do: "opacity-30 cursor-not-allowed", else: "")}
              >
                <span class="material-symbols-outlined text-lg">arrow_back</span>
                <span class="text-xs font-bold uppercase tracking-widest">Prev Set</span>
              </button>
              <div class="h-4 w-px bg-[#414755]/20"></div>
              <button
                phx-click="confirm_primary"
                class="text-[#C1C6D7] hover:text-[#FFB4AB] flex items-center gap-2 transition-colors"
              >
                <span class="material-symbols-outlined text-lg">delete</span>
                <span class="text-xs font-bold uppercase tracking-widest">Reject Others</span>
              </button>
            </div>
            <div class="flex items-center gap-3">
              <button
                phx-click="skip_group"
                class="text-[#C1C6D7] text-xs font-bold uppercase tracking-widest px-4 py-2 hover:bg-[#393939] rounded-lg transition-colors"
              >
                Skip Set
              </button>
              <button
                phx-click="confirm_primary"
                class="selection-gradient text-[#003549] px-6 py-2 rounded-lg text-xs font-bold uppercase tracking-widest shadow-lg shadow-[#7BD0FF]/20"
              >
                Next Batch
              </button>
            </div>
          </footer>
        <% end %>
      </div>
    </Layouts.app>
    """
  end
end
