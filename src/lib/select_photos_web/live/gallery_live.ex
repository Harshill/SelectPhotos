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
        # Select photo and stay in select mode so user can keep selecting
        {:ok, _photo} = Gallery.select_photo(photo)
        {:noreply, load_photos(socket)}
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
        # Create alternate group on-the-fly if primary doesn't have one yet
        primary =
          if primary.alternate_group_id == nil do
            {:ok, {_group, updated}} = Gallery.create_alternate_group(primary)
            updated
          else
            primary
          end

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
    <Layouts.app flash={@flash} active_page={:gallery} selected_count={@selected_count} total_count={@total_count}>
      <div class="flex flex-col h-full">
        <%!-- Toolbar --%>
        <div class="flex items-center justify-between px-6 py-4">
          <div class="flex items-center gap-4">
            <h1 class="text-2xl font-extrabold font-['Manrope'] tracking-tight text-[#E5E2E1]">Gallery</h1>
            <div class="flex gap-2">
              <span class="px-3 py-1 rounded-full bg-[#2A2A2A] text-[#C1C6D7] text-[10px] font-bold uppercase tracking-wider">
                All Assets
              </span>
              <span class="px-3 py-1 rounded-full bg-[#26467D] text-[#98B5F3] text-[10px] font-bold uppercase tracking-wider">
                Selected ({@selected_count})
              </span>
            </div>
          </div>

          <div class="flex items-center gap-3">
            <%!-- Directory loader --%>
            <form phx-submit="load_directory" class="flex items-center gap-2">
              <input
                type="text"
                name="directory"
                value={@directory}
                placeholder="Path to photo directory..."
                class="bg-[#1C1B1B] border-none rounded-lg px-4 py-1.5 text-xs text-[#E5E2E1] placeholder-[#8B90A0] w-72 focus:ring-1 focus:ring-[#7BD0FF]"
              />
              <button
                type="submit"
                class="selection-gradient text-[#003549] px-4 py-1.5 rounded-lg text-xs font-bold uppercase tracking-widest"
              >
                Load
              </button>
            </form>

            <%!-- Mode toggle pill --%>
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
                  "bg-[#2A2A2A] text-[#C1C6D7] hover:bg-[#353534]"
                end}
            >
              <span class={"w-2 h-2 rounded-full " <> if @mode == :alternate, do: "bg-[#351000]/40 animate-pulse", else: "bg-[#7BD0FF]"}></span>
              <%= if @mode == :alternate, do: "Alternate Mode", else: "Select Mode" %>
            </button>
          </div>
        </div>

        <%!-- Photo Grid --%>
        <div class="flex-1 overflow-y-auto p-6 pt-0 hide-scrollbar">
          <%= if @total_count == 0 do %>
            <div class="flex items-center justify-center h-full text-[#8B90A0]">
              <div class="text-center">
                <span class="material-symbols-outlined text-5xl text-[#353534] mb-4 block">photo_library</span>
                <p class="text-lg font-['Manrope'] font-bold mb-2">No photos loaded</p>
                <p class="text-sm">Enter a directory path above and click Load</p>
              </div>
            </div>
          <% else %>
            <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 xl:grid-cols-5 2xl:grid-cols-6 gap-4">
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
    <div class={"relative group aspect-[4/5] rounded-lg overflow-hidden bg-[#2A2A2A] #{@border_class} transition-all duration-200"}>
      <img
        src={"/thumbs/#{@photo.filename}"}
        alt={@photo.filename}
        loading="lazy"
        class="w-full h-full object-cover cursor-pointer transition-transform duration-500 group-hover:scale-110"
        phx-click="click_photo"
        phx-value-id={@photo.id}
      />

      <%!-- Selected star badge --%>
      <%= if @photo.status == "selected" and @photo.is_primary do %>
        <div class="absolute top-2 right-2 bg-[#7BD0FF]/20 backdrop-blur-md border border-[#7BD0FF]/30 p-1 rounded">
          <span class="material-symbols-outlined text-[#7BD0FF] text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
        </div>
      <% end %>

      <%!-- Active primary indicator in alternate mode --%>
      <%= if @photo.id == @alternate_primary_id do %>
        <div class="absolute top-2 right-2 px-2 py-0.5 rounded-full text-[10px] font-bold uppercase tracking-widest bg-[#FFB595] text-[#351000]">
          Adding alternates
        </div>
      <% end %>

      <%!-- Hover overlay with actions and filename --%>
      <div class="absolute inset-0 photo-card-gradient opacity-0 group-hover:opacity-100 transition-opacity flex flex-col justify-end p-3">
        <div class="flex justify-between items-center">
          <div class="flex gap-2">
            <%= if @photo.status in ["unreviewed", "rejected"] and @mode == :select do %>
              <button
                phx-click="reject_photo"
                phx-value-id={@photo.id}
                class="w-8 h-8 rounded-full bg-[#353534]/80 backdrop-blur-md flex items-center justify-center text-[#E5E2E1] hover:bg-[#FFB4AB] hover:text-[#690005] transition-all"
                title="Reject"
              >
                <span class="material-symbols-outlined text-lg">close</span>
              </button>
            <% end %>
          </div>
          <span class="text-[10px] font-mono text-[#E5E2E1]/60">{@photo.filename}</span>
        </div>
      </div>

      <%!-- Status badge --%>
      <%= if @photo.status != "unreviewed" do %>
        <div class={"absolute top-2 left-2 px-2 py-0.5 rounded text-[10px] font-bold uppercase tracking-widest #{status_badge_class(@photo)}"}>
          {status_label(@photo)}
        </div>
      <% end %>
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
