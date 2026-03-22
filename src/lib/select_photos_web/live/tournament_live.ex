defmodule SelectPhotosWeb.TournamentLive do
  use SelectPhotosWeb, :live_view

  alias SelectPhotos.Gallery

  @impl true
  def mount(_params, _session, socket) do
    directory = Application.get_env(:select_photos, :photo_directory, "")

    socket =
      socket
      |> assign(:directory, directory)
      |> assign(:target, 25)
      |> assign(:state, :setup)
      |> assign(:round, nil)
      |> assign(:current_match, nil)
      |> assign(:stats, nil)
      |> assign(:winners, nil)
      |> assign(:page_title, "Tournament")
      |> load_setup_info()

    {:ok, socket}
  end

  defp load_setup_info(socket) do
    directory = socket.assigns.directory
    selected_count = Gallery.selected_count(directory)
    unresolved = Gallery.unresolved_alternate_group_count(directory)

    socket
    |> assign(:selected_count, selected_count)
    |> assign(:unresolved_groups, unresolved)
  end

  @impl true
  def handle_event("start_tournament", _params, socket) do
    case Gallery.start_tournament(socket.assigns.directory, socket.assigns.target) do
      {:ok, _matches} ->
        {:noreply,
         socket
         |> assign(:state, :playing)
         |> assign(:round, 1)
         |> load_current_match()}

      {:error, :not_enough_photos} ->
        {:noreply, put_flash(socket, :error, "Need more than #{socket.assigns.target} selected photos to start a tournament")}
    end
  end

  @impl true
  def handle_event("update_target", %{"target" => target}, socket) do
    case Integer.parse(target) do
      {n, _} when n > 0 -> {:noreply, assign(socket, :target, n)}
      _ -> {:noreply, socket}
    end
  end

  @impl true
  def handle_event("pick_winner", %{"id" => id}, socket) do
    match = Gallery.get_match!(socket.assigns.current_match.id)
    winner = Gallery.get_photo!(id)
    {:ok, _} = Gallery.pick_winner(match, winner)

    if Gallery.round_complete?(socket.assigns.round) do
      case Gallery.advance_round(socket.assigns.round, socket.assigns.target) do
        {:done, winners} ->
          eliminate_losers(socket.assigns.directory, winners)

          {:noreply,
           socket
           |> assign(:state, :finished)
           |> assign(:winners, winners)}

        {:next, next_round, _matches} ->
          {:noreply,
           socket
           |> assign(:round, next_round)
           |> load_current_match()}
      end
    else
      {:noreply, load_current_match(socket)}
    end
  end

  @impl true
  def handle_event("reset_tournament", _params, socket) do
    Gallery.clear_tournament()

    {:noreply,
     socket
     |> assign(:state, :setup)
     |> assign(:round, nil)
     |> assign(:current_match, nil)
     |> assign(:stats, nil)
     |> assign(:winners, nil)
     |> load_setup_info()}
  end

  defp load_current_match(socket) do
    match = Gallery.current_match(socket.assigns.round)
    stats = Gallery.round_stats(socket.assigns.round)
    socket |> assign(:current_match, match) |> assign(:stats, stats)
  end

  defp eliminate_losers(directory, winners) do
    winner_ids = MapSet.new(Enum.map(winners, & &1.id))

    Gallery.list_selected(directory)
    |> Enum.reject(fn photo -> MapSet.member?(winner_ids, photo.id) end)
    |> Enum.each(&Gallery.reject_photo/1)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} active_page={:tournament} selected_count={@selected_count} total_count={@selected_count}>
      <div class="flex flex-col h-full">
        <%= case @state do %>
          <% :setup -> %>
            <.setup_view
              selected_count={@selected_count}
              target={@target}
              unresolved_groups={@unresolved_groups}
            />
          <% :playing -> %>
            <.playing_view
              current_match={@current_match}
              round={@round}
              stats={@stats}
              target={@target}
            />
          <% :finished -> %>
            <.finished_view winners={@winners} target={@target} />
        <% end %>
      </div>
    </Layouts.app>
    """
  end

  defp setup_view(assigns) do
    can_start = assigns.selected_count > assigns.target and assigns.unresolved_groups == 0

    assigns = assign(assigns, :can_start, can_start)

    ~H"""
    <div class="flex items-center justify-center h-full">
      <div class="text-center max-w-md">
        <div class="w-16 h-16 rounded-full bg-[#26467D]/30 flex items-center justify-center mx-auto mb-6">
          <span class="material-symbols-outlined text-3xl text-[#7BD0FF]">emoji_events</span>
        </div>
        <h1 class="font-['Manrope'] font-extrabold text-2xl text-[#E5E2E1] tracking-tight mb-2">
          Tournament Mode
        </h1>
        <p class="text-[#C1C6D7] text-sm mb-8">
          Head-to-head elimination to narrow your selections down to the best.
        </p>

        <div class="bg-[#1C1B1B] rounded-xl p-6 mb-6 border border-[#414755]/10">
          <div class="flex justify-between items-center mb-4">
            <span class="text-sm text-[#C1C6D7]">Selected photos</span>
            <span class="text-lg font-bold text-[#E5E2E1]">{@selected_count}</span>
          </div>
          <div class="flex justify-between items-center">
            <span class="text-sm text-[#C1C6D7]">Target</span>
            <form phx-change="update_target">
              <input
                type="number"
                value={@target}
                min="1"
                name="target"
                class="bg-[#353534] border-none rounded-lg px-3 py-1 text-sm text-[#E5E2E1] w-20 text-right focus:ring-1 focus:ring-[#7BD0FF]"
              />
            </form>
          </div>
        </div>

        <%= if @unresolved_groups > 0 do %>
          <div class="bg-[#353534] rounded-xl p-4 mb-6 border border-[#FFB595]/20">
            <p class="text-sm text-[#FFB595] font-bold mb-1">
              {@unresolved_groups} unresolved alternate group{if @unresolved_groups > 1, do: "s", else: ""}
            </p>
            <p class="text-xs text-[#C1C6D7] mb-3">
              Resolve all alternate groups in Compare before starting a tournament.
            </p>
            <a
              href="/compare"
              class="inline-block px-4 py-2 rounded-lg text-xs font-bold uppercase tracking-widest bg-[#FFB595] text-[#351000]"
            >
              Go to Compare
            </a>
          </div>
        <% else %>
          <%= if @can_start do %>
            <p class="text-xs text-[#C1C6D7] mb-4">
              {@selected_count - @target} photos will be eliminated over multiple rounds
            </p>
            <button
              phx-click="start_tournament"
              class="selection-gradient text-[#003549] px-8 py-3 rounded-lg text-sm font-bold uppercase tracking-widest"
            >
              Start Tournament
            </button>
          <% else %>
            <p class="text-xs text-[#8B90A0]">
              You have {@selected_count} selected — need more than {@target} to start
            </p>
          <% end %>
        <% end %>
      </div>
    </div>
    """
  end

  defp playing_view(assigns) do
    ~H"""
    <div class="flex flex-col h-full">
      <%!-- Tournament HUD (glass panel) --%>
      <div class="mx-6 mt-6 flex items-center justify-between glass-panel px-8 py-4 rounded-xl border border-[#414755]/10">
        <div class="flex items-center gap-4">
          <div class="w-10 h-10 rounded-full bg-[#26467D] flex items-center justify-center text-[#7BD0FF]">
            <span class="material-symbols-outlined">account_tree</span>
          </div>
          <div>
            <h1 class="text-sm font-['Manrope'] font-extrabold text-[#E5E2E1] tracking-tight">
              Round {@round}: Match {@stats.completed + 1} of {@stats.total}
            </h1>
            <p class="text-[10px] text-[#C1C6D7] uppercase tracking-widest">
              Selecting Top {@target}
            </p>
          </div>
        </div>
        <div class="flex items-center gap-8">
          <div class="flex items-center gap-3">
            <span class="text-[10px] font-bold text-[#C1C6D7]/50 uppercase tracking-widest">Progress</span>
            <div class="w-32 bg-[#353534] h-1.5 rounded-full overflow-hidden">
              <div
                class="bg-[#7BD0FF] h-full transition-all duration-300"
                style={"width: #{if @stats.total > 0, do: @stats.completed / @stats.total * 100, else: 0}%; box-shadow: 0 0 8px #7BD0FF;"}
              >
              </div>
            </div>
            <span class="text-xs font-bold font-['Manrope'] text-[#7BD0FF]">{@stats.remaining} left</span>
          </div>
          <button
            phx-click="reset_tournament"
            class="px-3 py-1.5 rounded-lg text-xs font-bold uppercase tracking-widest bg-[#353534] text-[#C1C6D7] hover:bg-[#414755] transition-colors"
          >
            Reset
          </button>
        </div>
      </div>

      <%!-- Match area --%>
      <%= if @current_match do %>
        <div class="flex-1 flex items-center justify-center p-8 relative min-h-0">
          <div class="w-full max-w-6xl grid grid-cols-2 gap-8 h-full max-h-full">
            <%!-- Left competitor --%>
            <div class="flex flex-col gap-4 min-h-0">
              <div class="relative flex-1 min-h-0 rounded-xl overflow-hidden bg-[#1C1B1B] border-2 border-transparent hover:border-[#7BD0FF]/30 transition-all duration-300 shadow-2xl">
                <img
                  src={"/photos/#{@current_match.photo_left.filename}"}
                  alt={@current_match.photo_left.filename}
                  class="w-full h-full object-contain"
                />
              </div>
              <button
                phx-click="pick_winner"
                phx-value-id={@current_match.photo_left.id}
                class="shrink-0 w-full py-4 bg-[#353534] hover:bg-gradient-to-r hover:from-[#7BD0FF] hover:to-[#009BD1] hover:text-[#003549] transition-all duration-300 rounded-xl flex items-center justify-center gap-3 group/btn cursor-pointer"
              >
                <span class="text-sm font-['Manrope'] font-bold uppercase tracking-widest">{@current_match.photo_left.filename}</span>
                <span class="material-symbols-outlined text-lg opacity-0 group-hover/btn:opacity-100 transition-opacity" style="font-variation-settings: 'FILL' 1;">check_circle</span>
              </button>
            </div>

            <%!-- VS badge --%>
            <div class="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 z-10">
              <div class="w-12 h-12 rounded-full glass-panel border border-[#7BD0FF]/40 flex items-center justify-center shadow-[0_0_20px_rgba(123,208,255,0.2)]">
                <span class="text-xs font-['Manrope'] font-black text-[#7BD0FF] italic">VS</span>
              </div>
            </div>

            <%!-- Right competitor --%>
            <div class="flex flex-col gap-4 min-h-0">
              <div class="relative flex-1 min-h-0 rounded-xl overflow-hidden bg-[#1C1B1B] border-2 border-transparent hover:border-[#7BD0FF]/30 transition-all duration-300 shadow-2xl">
                <img
                  src={"/photos/#{@current_match.photo_right.filename}"}
                  alt={@current_match.photo_right.filename}
                  class="w-full h-full object-contain"
                />
              </div>
              <button
                phx-click="pick_winner"
                phx-value-id={@current_match.photo_right.id}
                class="shrink-0 w-full py-4 bg-[#353534] hover:bg-gradient-to-r hover:from-[#7BD0FF] hover:to-[#009BD1] hover:text-[#003549] transition-all duration-300 rounded-xl flex items-center justify-center gap-3 group/btn cursor-pointer"
              >
                <span class="text-sm font-['Manrope'] font-bold uppercase tracking-widest">{@current_match.photo_right.filename}</span>
                <span class="material-symbols-outlined text-lg opacity-0 group-hover/btn:opacity-100 transition-opacity" style="font-variation-settings: 'FILL' 1;">check_circle</span>
              </button>
            </div>
          </div>
        </div>

        <%!-- Bottom toolbar --%>
        <div class="flex items-center justify-center pb-6">
          <div class="flex items-center gap-4 px-6 py-3 rounded-full glass-panel border border-[#414755]/10">
            <button class="p-2 hover:bg-[#2A2A2A] rounded-lg text-[#C1C6D7] flex items-center gap-2 transition-all">
              <span class="material-symbols-outlined text-sm">keyboard_arrow_left</span>
              <span class="text-[10px] font-bold uppercase tracking-widest">Undo Last</span>
            </button>
            <div class="w-px h-4 bg-[#414755]/20 mx-2"></div>
            <button
              phx-click="reset_tournament"
              class="p-2 hover:bg-[#2A2A2A] rounded-lg text-[#C1C6D7] flex items-center gap-2 transition-all"
            >
              <span class="text-[10px] font-bold uppercase tracking-widest">Exit Mode</span>
              <span class="material-symbols-outlined text-sm">close</span>
            </button>
          </div>
        </div>
      <% end %>
    </div>
    """
  end

  defp finished_view(assigns) do
    ~H"""
    <div class="flex flex-col h-full">
      <div class="flex items-center justify-between px-6 py-4">
        <div class="flex items-center gap-4">
          <div class="w-10 h-10 rounded-full bg-[#26467D] flex items-center justify-center">
            <span class="material-symbols-outlined text-[#7BD0FF]" style="font-variation-settings: 'FILL' 1;">emoji_events</span>
          </div>
          <div>
            <h1 class="font-['Manrope'] font-extrabold text-xl text-[#E5E2E1] tracking-tight">
              Tournament Complete
            </h1>
            <p class="text-[#C1C6D7] text-sm">
              {length(@winners)} photos made the final cut
            </p>
          </div>
        </div>
        <div class="flex items-center gap-3">
          <button
            phx-click="reset_tournament"
            class="px-4 py-2 rounded-lg text-xs font-bold uppercase tracking-widest bg-[#353534] text-[#C1C6D7] hover:bg-[#414755] transition-colors"
          >
            Reset
          </button>
          <a
            href="/export"
            class="selection-gradient text-[#003549] px-6 py-2 rounded-lg text-xs font-bold uppercase tracking-widest shadow-lg shadow-[#7BD0FF]/20"
          >
            Export
          </a>
        </div>
      </div>

      <div class="flex-1 overflow-y-auto p-6 hide-scrollbar">
        <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
          <%= for photo <- @winners do %>
            <div class="rounded-xl overflow-hidden bg-[#1C1B1B] ring-2 ring-[#7BD0FF] group">
              <img
                src={"/photos/#{photo.filename}"}
                alt={photo.filename}
                class="w-full aspect-square object-cover transition-transform duration-500 group-hover:scale-110"
              />
              <div class="p-2">
                <span class="text-[10px] text-[#C1C6D7] font-mono truncate block">{photo.filename}</span>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    </div>
    """
  end
end
