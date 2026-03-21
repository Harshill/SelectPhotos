defmodule SelectPhotosWeb.GalleryLive do
  use SelectPhotosWeb, :live_view

  alias SelectPhotos.Gallery

  @impl true
  def mount(_params, _session, socket) do
    directory = Application.get_env(:select_photos, :photo_directory, "")

    socket =
      socket
      |> assign(:directory, directory)
      |> assign(:mode, :select)
      |> assign(:alternate_primary_id, nil)
      |> assign(:last_primary_id, nil)
      |> assign(:page_title, "Gallery")
      |> load_photos()

    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("load_directory", %{"directory" => directory}, socket) do
    directory = Path.expand(directory)

    case Gallery.load_from_directory(directory) do
      {:ok, count} ->
        socket =
          socket
          |> assign(:directory, directory)
          |> put_flash(:info, "Loaded #{count} photos")
          |> load_photos()

        {:noreply, socket}

      {:error, :not_a_directory} ->
        {:noreply, put_flash(socket, :error, "Not a valid directory")}
    end
  end

  @impl true
  def handle_event("toggle_mode", _params, socket) do
    case socket.assigns.mode do
      :select ->
        # Re-enter alternate mode with the last primary if we have one
        {:noreply,
         socket
         |> assign(:mode, :alternate)
         |> assign(:alternate_primary_id, socket.assigns.last_primary_id)}

      :alternate ->
        # Remember current primary so we can resume later
        {:noreply,
         socket
         |> assign(:mode, :select)
         |> assign(:last_primary_id, socket.assigns.alternate_primary_id)
         |> assign(:alternate_primary_id, nil)}
    end
  end

  @impl true
  def handle_event("click_photo", %{"id" => id}, socket) do
    photo = Gallery.get_photo!(id)

    case socket.assigns.mode do
      :select -> handle_select_click(socket, photo)
      :alternate -> handle_alternate_click(socket, photo)
    end
  end

  @impl true
  def handle_event("reject_photo", %{"id" => id}, socket) do
    photo = Gallery.get_photo!(id)
    {:ok, _} = Gallery.reject_photo(photo)
    {:noreply, load_photos(socket)}
  end

  # -- Select mode: select a photo, make it primary, auto-switch to alternate mode --

  defp handle_select_click(socket, photo) do
    case photo.status do
      "selected" ->
        {:ok, _} = Gallery.deselect_photo(photo)
        {:noreply, load_photos(socket)}

      "alternate" ->
        {:noreply, put_flash(socket, :info, "This photo is an alternate. Remove it from its group first.")}

      _ ->
        # Select photo, create group, and auto-enter alternate mode
        {:ok, photo} = Gallery.select_photo(photo)
        {:ok, {_group, photo}} = Gallery.create_alternate_group(photo)

        {:noreply,
         socket
         |> load_photos()
         |> assign(:mode, :alternate)
         |> assign(:alternate_primary_id, photo.id)
         |> assign(:last_primary_id, photo.id)}
    end
  end

  # -- Alternate mode: click photos to add as alternates to current primary --

  defp handle_alternate_click(socket, photo) do
    primary = Gallery.get_photo!(socket.assigns.alternate_primary_id)

    cond do
      photo.id == primary.id ->
        {:noreply, socket}

      photo.alternate_group_id != nil ->
        {:noreply, put_flash(socket, :info, "This photo already belongs to a group")}

      true ->
        group = Gallery.get_group_with_photos(primary.alternate_group_id)
        {:ok, _} = Gallery.add_alternate(group, photo)
        {:noreply, load_photos(socket)}
    end
  end

  defp load_photos(socket) do
    directory = socket.assigns.directory
    photos = Gallery.list_photos(directory)
    selected_count = Enum.count(photos, &(&1.status == "selected"))

    socket
    |> assign(:photos, photos)
    |> assign(:total_count, length(photos))
    |> assign(:selected_count, selected_count)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="flex flex-col h-full">
        <%!-- Top bar: directory loader + mode toggle + stats --%>
        <div class="flex items-center justify-between px-6 py-4 border-b border-[#414755]/20">
          <div class="flex items-center gap-6">
            <form phx-submit="load_directory" class="flex items-center gap-3">
              <input
                type="text"
                name="directory"
                value={@directory}
                placeholder="Path to photo directory..."
                class="bg-[#1C1B1B] border border-[#414755]/30 rounded-lg px-4 py-2 text-sm text-[#E5E2E1] placeholder-[#8B90A0] w-96 focus:outline-none focus:border-[#7BD0FF]/50"
              />
              <button
                type="submit"
                class="bg-gradient-to-br from-[#7BD0FF] to-[#009BD1] text-[#003549] px-4 py-2 rounded-lg text-xs font-bold uppercase tracking-widest"
              >
                Load
              </button>
            </form>
            <div class="flex items-center gap-4 text-sm text-[#C1C6D7]">
              <span>{@selected_count} selected</span>
              <span class="text-[#414755]">|</span>
              <span>{@total_count} total</span>
            </div>
          </div>

          <%!-- Mode toggle pill --%>
          <div class="flex items-center gap-3">
            <%= if @mode == :alternate do %>
              <span class="text-xs text-[#C1C6D7]">
                Click photos to add as alternates
              </span>
            <% end %>
            <button
              phx-click="toggle_mode"
              class={"flex items-center gap-2 px-4 py-2 rounded-full text-xs font-bold uppercase tracking-widest transition-all duration-200 " <>
                if @mode == :alternate do
                  "bg-[#FFB595] text-[#351000]"
                else
                  "bg-[#353534] text-[#C1C6D7] hover:bg-[#414755]"
                end}
            >
              <span class={"w-2 h-2 rounded-full " <> if @mode == :alternate, do: "bg-[#351000]/40 animate-pulse", else: "bg-[#7BD0FF]"}></span>
              <%= if @mode == :alternate, do: "Alternate Mode", else: "Select Mode" %>
            </button>
          </div>
        </div>

        <%!-- Photo Grid --%>
        <div class="flex-1 overflow-y-auto p-6">
          <%= if @total_count == 0 do %>
            <div class="flex items-center justify-center h-full text-[#8B90A0]">
              <div class="text-center">
                <p class="text-lg font-['Manrope'] font-bold mb-2">No photos loaded</p>
                <p class="text-sm">Enter a directory path above and click Load</p>
              </div>
            </div>
          <% else %>
            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 2xl:grid-cols-6 gap-4">
              <%= for photo <- @photos do %>
                <.photo_card
                  photo={photo}
                  mode={@mode}
                  alternate_primary_id={@alternate_primary_id}
                />
              <% end %>
            </div>
          <% end %>
        </div>
      </div>
    </Layouts.app>
    """
  end

  defp photo_card(assigns) do
    border_class =
      cond do
        assigns.photo.id == assigns.alternate_primary_id ->
          "ring-2 ring-[#FFB595] ring-offset-1 ring-offset-[#131313]"

        assigns.photo.status == "selected" && assigns.photo.is_primary ->
          "ring-2 ring-[#7BD0FF] ring-offset-1 ring-offset-[#131313]"

        assigns.photo.status == "selected" ->
          "ring-2 ring-[#7BD0FF]"

        assigns.photo.status == "alternate" ->
          "ring-2 ring-[#ADC6FF]/50"

        assigns.photo.status == "rejected" ->
          "opacity-30"

        true ->
          ""
      end

    assigns = assign(assigns, :border_class, border_class)

    ~H"""
    <div class={"relative group rounded-lg overflow-hidden bg-[#1C1B1B] #{@border_class} transition-all duration-200"}>
      <img
        src={"/photos/#{@photo.filename}"}
        alt={@photo.filename}
        class="w-full aspect-square object-cover cursor-pointer"
        phx-click="click_photo"
        phx-value-id={@photo.id}
      />

      <%!-- Status badge --%>
      <%= if @photo.status != "unreviewed" do %>
        <div class={"absolute top-2 left-2 px-2 py-0.5 rounded-full text-[10px] font-bold uppercase tracking-widest #{status_badge_class(@photo)}"}>
          {status_label(@photo)}
        </div>
      <% end %>

      <%!-- Active primary indicator in alternate mode --%>
      <%= if @photo.id == @alternate_primary_id do %>
        <div class="absolute top-2 right-2 px-2 py-0.5 rounded-full text-[10px] font-bold uppercase tracking-widest bg-[#FFB595] text-[#351000]">
          Adding alternates
        </div>
      <% end %>

      <%!-- Hover actions --%>
      <div class="absolute bottom-2 right-2 flex gap-1.5 opacity-0 group-hover:opacity-100 transition-opacity">
        <%= if @photo.status in ["unreviewed", "rejected"] and @mode == :select do %>
          <button
            phx-click="reject_photo"
            phx-value-id={@photo.id}
            class="p-1.5 rounded-lg bg-[#353534]/80 text-[#C1C6D7] hover:text-[#FFB4AB] hover:bg-[#414755] transition-colors text-xs"
            title="Reject"
          >
            ✕
          </button>
        <% end %>
      </div>

      <%!-- Filename on hover --%>
      <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/60 to-transparent p-2 opacity-0 group-hover:opacity-100 transition-opacity">
        <span class="text-[10px] text-[#C1C6D7] font-mono truncate block">{@photo.filename}</span>
      </div>
    </div>
    """
  end

  defp status_badge_class(photo) do
    case {photo.status, photo.is_primary} do
      {"selected", true} -> "bg-[#7BD0FF]/90 text-[#003549]"
      {"selected", _} -> "bg-[#7BD0FF]/90 text-[#003549]"
      {"alternate", _} -> "bg-[#ADC6FF]/80 text-[#001A41]"
      {"rejected", _} -> "bg-[#353534] text-[#8B90A0]"
      _ -> ""
    end
  end

  defp status_label(photo) do
    case {photo.status, photo.is_primary} do
      {"selected", true} -> "Primary"
      {"selected", false} -> "Selected"
      {"alternate", _} -> "Alt"
      {"rejected", _} -> "Rejected"
      _ -> ""
    end
  end
end
