defmodule B2Web.GameLive do
  use B2Web, :live_view

  def mount(_params, _session, socket) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)

    socket =
      socket
      |> assign(%{game: game, tally: tally})

    {:ok, socket}
  end

  def handle_event("make_move", %{"key" => key}, socket) do
    tally = Hangman.make_move(socket.assigns.game, key)
    {:noreply, assign(socket, :tally, tally)}
  end

  def render(assigns) do
    ~H"""
    <div class="game-holder" phx-window-keyup="make_move">
      <.live_component module={__MODULE__.FigureComponent} id="figure" tally={@tally} />
      <.live_component module={__MODULE__.AlphabetComponent} id="alphabet" tally={@tally} />
      <.live_component module={__MODULE__.WordSoFarComponent} id="wordsofar" tally={@tally} />
    </div>
    """
  end
end
