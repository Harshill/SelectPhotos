defmodule SelectPhotosWeb.DashboardLive do
  use SelectPhotosWeb, :live_view

  alias SelectPhotos.Gallery

  @impl true
  def mount(_params, _session, socket) do
    directory = Application.get_env(:select_photos, :photo_directory, "")

    socket =
      socket
      |> assign(:directory, directory)
      |> assign(:page_title, "Dashboard")
      |> load_stats()

    {:ok, socket}
  end

  defp load_stats(socket) do
    directory = socket.assigns.directory
    photos = Gallery.list_photos(directory)
    total = length(photos)
    selected = Enum.count(photos, &(&1.status == "selected"))
    rejected = Enum.count(photos, &(&1.status == "rejected"))
    alternates = Enum.count(photos, &(&1.status == "alternate"))
    unreviewed = Enum.count(photos, &(&1.status == "unreviewed"))
    unresolved_groups = Gallery.unresolved_alternate_group_count(directory)
    preview_photos = Enum.take(photos, 6)

    progress = if total > 0, do: Float.round(selected / 25 * 100, 0), else: 0

    socket
    |> assign(:total, total)
    |> assign(:selected, selected)
    |> assign(:rejected, rejected)
    |> assign(:alternates, alternates)
    |> assign(:unreviewed, unreviewed)
    |> assign(:unresolved_groups, unresolved_groups)
    |> assign(:preview_photos, preview_photos)
    |> assign(:progress, min(progress, 100))
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} active_page={:dashboard} selected_count={@selected} total_count={@total}>
      <div class="flex flex-col h-full overflow-y-auto hide-scrollbar">
        <div class="px-10 py-8">
          <%!-- Header --%>
          <div class="mb-12">
            <h1 class="font-['Manrope'] font-extrabold text-4xl text-[#E5E2E1] tracking-tight mb-2">
              Project Dashboard
            </h1>
            <p class="text-[#C1C6D7] text-sm">
              Manage your curation workflow and selection progress.
            </p>
          </div>

          <%!-- Bento grid --%>
          <div class="grid grid-cols-12 gap-6">
            <%!-- Left column: Stats --%>
            <div class="col-span-12 lg:col-span-4 flex flex-col gap-6">
              <%!-- Summary card --%>
              <div class="bg-[#1C1B1B] p-8 rounded-xl border border-[#414755]/10">
                <div class="flex justify-between items-start mb-8">
                  <div>
                    <span class="text-xs font-bold uppercase tracking-widest text-[#C1C6D7] mb-1 block">
                      Import Summary
                    </span>
                    <h3 class="text-3xl font-['Manrope'] font-bold text-[#E5E2E1]">
                      {@total} Photos
                    </h3>
                  </div>
                  <div class="bg-[#2A2A2A] p-3 rounded-lg">
                    <span class="material-symbols-outlined text-[#7BD0FF]">photo_library</span>
                  </div>
                </div>

                <div class="space-y-6">
                  <%!-- Progress bar --%>
                  <div>
                    <div class="flex justify-between text-xs font-bold uppercase tracking-widest text-[#C1C6D7] mb-3">
                      <span>Selection Progress</span>
                      <span class="text-[#7BD0FF]">{trunc(@progress)}%</span>
                    </div>
                    <div class="w-full h-2 bg-[#353534] rounded-full overflow-hidden">
                      <div
                        class="h-full selection-gradient rounded-full transition-all duration-500"
                        style={"width: #{@progress}%"}
                      >
                      </div>
                    </div>
                    <div class="mt-3 text-xs text-[#C1C6D7]">
                      {@selected} / 25 target images selected
                    </div>
                  </div>

                  <%!-- Start selection CTA --%>
                  <a
                    href="/gallery"
                    class="w-full selection-gradient text-[#003549] font-['Manrope'] font-extrabold py-4 rounded-xl text-lg flex items-center justify-center gap-2 group"
                  >
                    <span><%= if @selected == 0, do: "Start Selection", else: "Continue Selection" %></span>
                    <span class="material-symbols-outlined transition-transform group-hover:translate-x-1">arrow_forward</span>
                  </a>
                </div>
              </div>

              <%!-- Status breakdown card --%>
              <div class="bg-[#1C1B1B] p-6 rounded-xl border border-[#414755]/10">
                <h4 class="text-xs font-bold uppercase tracking-widest text-[#C1C6D7] mb-4">
                  Status Breakdown
                </h4>
                <div class="space-y-3">
                  <.stat_row label="Unreviewed" count={@unreviewed} color="#8B90A0" />
                  <.stat_row label="Selected" count={@selected} color="#7BD0FF" />
                  <.stat_row label="Alternates" count={@alternates} color="#ADC6FF" />
                  <.stat_row label="Rejected" count={@rejected} color="#FFB4AB" />
                </div>
              </div>
            </div>

            <%!-- Right column: Preview grid --%>
            <div class="col-span-12 lg:col-span-8 bg-[#1C1B1B] rounded-xl border border-[#414755]/10 p-2 overflow-hidden">
              <div class="p-6 flex justify-between items-center">
                <h4 class="text-xs font-bold uppercase tracking-widest text-[#C1C6D7]">
                  Import Preview
                </h4>
                <a href="/gallery" class="text-xs font-bold text-[#7BD0FF] flex items-center gap-1 hover:underline">
                  View All <span class="material-symbols-outlined text-sm">open_in_new</span>
                </a>
              </div>
              <div class="grid grid-cols-2 md:grid-cols-3 gap-2">
                <%= for photo <- @preview_photos do %>
                  <div class="relative group overflow-hidden rounded-lg bg-[#2A2A2A] aspect-square">
                    <img
                      src={"/thumbs/#{photo.filename}"}
                      loading="lazy"
                      alt={photo.filename}
                      class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                    />
                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex items-end p-4">
                      <span class="text-xs font-medium text-white font-mono">{photo.filename}</span>
                    </div>
                  </div>
                <% end %>
              </div>
            </div>

            <%!-- Workflow status bar (glassmorphism) --%>
            <div class="col-span-12 glass-panel p-4 rounded-xl border border-white/5 flex items-center justify-between mt-2">
              <div class="flex items-center gap-6">
                <.workflow_step label="Gallery" href="/gallery" done={@total > 0} active={@selected == 0 and @total > 0} icon="grid_view" />
                <div class="w-8 h-px bg-[#414755]/30"></div>
                <.workflow_step label="Compare" href="/compare" done={@unresolved_groups == 0 and @selected > 0} active={@unresolved_groups > 0} icon="compare" />
                <div class="w-8 h-px bg-[#414755]/30"></div>
                <.workflow_step label="Tournament" href="/tournament" done={false} active={@selected > 25 and @unresolved_groups == 0} icon="emoji_events" />
                <div class="w-8 h-px bg-[#414755]/30"></div>
                <.workflow_step label="Export" href="/export" done={false} active={@selected > 0 and @selected <= 25} icon="ios_share" />
              </div>
              <div class="flex items-center gap-2 text-xs text-[#C1C6D7]">
                <span class="material-symbols-outlined text-sm text-[#C1C6D7]/50" style="font-variation-settings: 'FILL' 1;">folder</span>
                <span class="font-mono text-[10px] text-[#C1C6D7]/70">{@directory}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </Layouts.app>
    """
  end

  defp stat_row(assigns) do
    ~H"""
    <div class="flex justify-between items-center">
      <div class="flex items-center gap-2">
        <div class="w-2 h-2 rounded-full" style={"background-color: #{@color}"}></div>
        <span class="text-sm text-[#C1C6D7]">{@label}</span>
      </div>
      <span class="text-sm font-bold text-[#E5E2E1]">{@count}</span>
    </div>
    """
  end

  defp workflow_step(assigns) do
    text_class =
      cond do
        assigns.done -> "text-[#7BD0FF]"
        assigns.active -> "text-[#E5E2E1]"
        true -> "text-[#8B90A0]"
      end

    assigns = assign(assigns, :text_class, text_class)

    ~H"""
    <a href={@href} class={"flex items-center gap-2 text-xs font-bold uppercase tracking-widest #{@text_class} hover:text-[#7BD0FF] transition-colors"}>
      <%= if @done do %>
        <span class="material-symbols-outlined text-sm text-[#7BD0FF]" style="font-variation-settings: 'FILL' 1;">check_circle</span>
      <% end %>
      <%= if @active do %>
        <span class="w-2 h-2 rounded-full bg-[#7BD0FF] animate-pulse"></span>
      <% end %>
      {@label}
    </a>
    """
  end
end
