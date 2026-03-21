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
    <Layouts.app flash={@flash}>
      <div class="flex flex-col h-full">
        <%!-- Header --%>
        <div class="flex items-center justify-between px-6 py-4 border-b border-[#414755]/20">
          <div>
            <h1 class="font-['Manrope'] font-extrabold text-xl text-[#E5E2E1] tracking-tight">
              Final Selection
            </h1>
            <p class="text-[#C1C6D7] text-sm">
              {length(@selected)} photos ready for export
            </p>
          </div>
          <div class="flex items-center gap-3">
            <button
              phx-click="export_txt"
              class="bg-gradient-to-br from-[#7BD0FF] to-[#009BD1] text-[#003549] px-6 py-2 rounded-lg text-xs font-bold uppercase tracking-widest"
            >
              Export as selects.txt
            </button>
          </div>
        </div>

        <%!-- Selected photos grid --%>
        <div class="flex-1 overflow-y-auto p-6">
          <%= if @selected == [] do %>
            <div class="flex items-center justify-center h-full text-[#8B90A0]">
              <div class="text-center">
                <p class="text-lg font-['Manrope'] font-bold mb-2">No selections yet</p>
                <p class="text-sm mb-4">Go to the Gallery to select photos</p>
                <a
                  href="/gallery"
                  class="bg-gradient-to-br from-[#7BD0FF] to-[#009BD1] text-[#003549] px-6 py-2 rounded-lg text-xs font-bold uppercase tracking-widest"
                >
                  Back to Gallery
                </a>
              </div>
            </div>
          <% else %>
            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 2xl:grid-cols-6 gap-4">
              <%= for {photo, i} <- Enum.with_index(@selected, 1) do %>
                <div class="rounded-xl overflow-hidden bg-[#1C1B1B] ring-1 ring-[#414755]/20">
                  <img
                    src={"/thumbs/#{photo.filename}"}
                    loading="lazy"
                    alt={photo.filename}
                    class="w-full aspect-square object-cover"
                  />
                  <div class="p-2 flex items-center justify-between">
                    <span class="text-[10px] text-[#C1C6D7] font-mono truncate">{photo.filename}</span>
                    <span class="text-[10px] font-bold text-[#7BD0FF]">#{i}</span>
                  </div>
                </div>
              <% end %>
            </div>

            <%!-- Filename list --%>
            <div class="mt-8 bg-[#1C1B1B] rounded-xl p-6 border border-[#414755]/10">
              <h2 class="text-sm font-['Manrope'] font-bold text-[#E5E2E1] mb-3">Filenames</h2>
              <pre class="text-xs text-[#C1C6D7] font-mono whitespace-pre-wrap"><%= Enum.map_join(@selected, "\n", & &1.filename) %></pre>
            </div>
          <% end %>
        </div>
      </div>
    </Layouts.app>
    """
  end
end
