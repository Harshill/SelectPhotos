defmodule SelectPhotosWeb.ExportLive do
  use SelectPhotosWeb, :live_view

  alias SelectPhotos.Gallery

  @impl true
  def mount(_params, _session, socket) do
    directory = Application.get_env(:select_photos, :photo_directory, "")
    selected = Gallery.list_selected(directory)

    socket =
      socket
      |> assign(:directory, directory)
      |> assign(:selected, selected)
      |> assign(:page_title, "Export")

    {:ok, socket}
  end

  @impl true
  def handle_event("export_txt", _params, socket) do
    selected = socket.assigns.selected
    directory = socket.assigns.directory

    content = Enum.map_join(selected, "\n", & &1.filename)
    export_path = Path.join(directory, "selects.txt")

    case File.write(export_path, content) do
      :ok ->
        {:noreply, put_flash(socket, :info, "Exported #{length(selected)} filenames to #{export_path}")}

      {:error, reason} ->
        {:noreply, put_flash(socket, :error, "Failed to export: #{reason}")}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} active_page={:export} selected_count={length(@selected)} total_count={length(@selected)}>
      <div class="flex flex-col h-full">
        <%= if @selected == [] do %>
          <%!-- Empty state --%>
          <div class="flex items-center justify-center h-full text-[#8B90A0]">
            <div class="text-center">
              <span class="material-symbols-outlined text-5xl text-[#353534] mb-4 block">ios_share</span>
              <p class="text-lg font-['Manrope'] font-bold mb-2">No selections yet</p>
              <p class="text-sm mb-4">Go to the Gallery to select photos</p>
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
          <div class="px-6 lg:px-12 pt-8 pb-6">
            <h1 class="text-3xl font-['Manrope'] font-extrabold tracking-tight text-[#E5E2E1] mb-2">
              Export Summary
            </h1>
            <p class="text-[#C1C6D7] max-w-2xl text-sm">
              Review your final selection of {length(@selected)} assets. Export the file manifest to hand off for post-production.
            </p>
          </div>

          <%!-- Content --%>
          <div class="flex-1 overflow-y-auto px-6 lg:px-12 pb-12 hide-scrollbar">
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
              <%!-- Left: File Manifest --%>
              <div class="lg:col-span-5 space-y-6">
                <div class="bg-[#1C1B1B] p-6 rounded-xl">
                  <div class="flex justify-between items-center mb-6">
                    <h2 class="text-sm font-bold uppercase tracking-widest text-[#C1C6D7]">File Manifest</h2>
                    <span class="text-xs bg-[#353534] px-2 py-1 rounded text-[#7BD0FF]">{length(@selected)} FILES</span>
                  </div>
                  <div class="max-h-[500px] overflow-y-auto pr-2 space-y-1 custom-scrollbar">
                    <%= for photo <- @selected do %>
                      <div class="group flex items-center justify-between p-3 rounded-lg hover:bg-[#2A2A2A] transition-colors">
                        <span class="font-mono text-sm text-[#E5E2E1]/80">{photo.filename}</span>
                      </div>
                    <% end %>
                  </div>
                </div>

                <%!-- Export Actions --%>
                <div class="bg-[#1C1B1B] p-6 rounded-xl space-y-3">
                  <h2 class="text-sm font-bold uppercase tracking-widest text-[#C1C6D7] mb-4">Export Actions</h2>
                  <button
                    phx-click="export_txt"
                    class="w-full selection-gradient text-[#003549] py-3 rounded-lg text-sm font-bold flex items-center justify-center gap-2 shadow-lg shadow-[#7BD0FF]/20"
                  >
                    <span class="material-symbols-outlined text-sm">download</span>
                    Export as selects.txt
                  </button>
                </div>
              </div>

              <%!-- Right: Photo Grid Preview --%>
              <div class="lg:col-span-7">
                <div class="bg-[#1C1B1B] p-6 rounded-xl">
                  <h2 class="text-sm font-bold uppercase tracking-widest text-[#C1C6D7] mb-6">Final Gallery</h2>
                  <div class="grid grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-3">
                    <%= for {photo, i} <- Enum.with_index(@selected, 1) do %>
                      <div class="group relative rounded-lg overflow-hidden bg-[#2A2A2A]">
                        <img
                          src={"/thumbs/#{photo.filename}"}
                          loading="lazy"
                          alt={photo.filename}
                          class="w-full aspect-square object-cover transition-transform duration-500 group-hover:scale-110"
                        />
                        <div class="absolute inset-0 photo-card-gradient opacity-0 group-hover:opacity-100 transition-opacity flex items-end p-3">
                          <div class="flex justify-between items-center w-full">
                            <span class="text-[10px] font-mono text-[#E5E2E1]/60">{photo.filename}</span>
                            <span class="text-[10px] font-bold text-[#7BD0FF]">#{i}</span>
                          </div>
                        </div>
                      </div>
                    <% end %>
                  </div>
                </div>
              </div>
            </div>
          </div>
        <% end %>
      </div>
    </Layouts.app>
    """
  end
end
