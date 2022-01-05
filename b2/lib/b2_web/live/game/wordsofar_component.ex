defmodule B2Web.GameLive.WordSoFarComponent do
  use B2Web, :live_component

  @states %{
    already_used: "You already picked that letter",
    bad_guess: "That's not in the word",
    good_guess: "Good guess!",
    initializing: "Type or click on your first guess",
    invalid_guess: "Sorry, that's not a valid guess",
    lost: "Sorry, you lost...",
    not_initialized: "The game wasn't initialized properly",
    won: "You won!"
  }

  def render(assigns) do
    ~H"""
    <div class="word-so-far">
      <div class="game-state">
        <%= state_name(@tally.game_state) %>
      </div>
      <div class="letters">
        <%= for ch <- @tally.letters do %>
          <div class={letter_class(ch)}>
            <%= ch %>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  defp state_name(state) do
    @states[state] || "Unknown state"
  end

  defp letter_class("_"), do: "one-letter"
  defp letter_class(_), do: "one-letter correct"
end
