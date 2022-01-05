defmodule B2Web.GameLive.AlphabetComponent do
  use B2Web, :live_component

  def mount(socket) do
    letters = ?a..?z |> Enum.map(&<<&1::utf8>>)
    {:ok, assign(socket, :letters, letters)}
  end

  def render(assigns) do
    ~H"""
    <div class="alphabet">
      <%= for letter <- @letters do %>
        <div class={letter_class(letter, @tally)} phx-click="make_move" phx-value-key={letter}>
          <%= letter %>
        </div>
      <% end %>
    </div>
    """
  end

  defp letter_class(letter, tally) do
    "one-letter#{class_of(letter, tally)}"
  end

  defp class_of(letter, tally) do
    cond do
      Enum.member?(tally.letters, letter) -> " correct"
      Enum.member?(tally.used, letter) -> " wrong"
      true -> ""
    end
  end
end
