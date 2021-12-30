defmodule Hangman.Impl.Game do
  alias Hangman.Type

  @type t :: %__MODULE__{
          turns_left: integer(),
          game_state: Type.state(),
          letters: list(String.t()),
          used: MapSet.t(String.t())
        }

  defstruct turns_left: 7, game_state: :initializing, letters: [], used: MapSet.new()

  @spec new_game() :: t
  def new_game do
    new_game(Dictionary.random_word())
  end

  @spec new_game(String.t()) :: t
  def new_game(word) do
    letters = word |> String.codepoints()
    accept_initialization(letters, Enum.all?(letters, &valid_letter?(&1)))
  end

  @spec make_move(t, String.t()) :: {t, Type.tally()}
  def make_move(game = %{game_state: state}, _guess) when state in [:won, :lost] do
    game
    |> return_with_tally()
  end

  def make_move(game, guess) do
    accept_move(game, guess, valid_letter?(guess))
    |> return_with_tally()
  end

  defp accept_initialization(letters, _valid_initialization = true) do
    %__MODULE__{
      letters: letters
    }
  end

  defp accept_initialization(_letters, _valid_initialization) do
    %__MODULE__{
      turns_left: 0,
      game_state: :not_initialized
    }
  end

  defp accept_move(game, guess, _valid_move = true) do
    accept_guess(game, guess, MapSet.member?(game.used, guess))
  end

  defp accept_move(game, _guess, _valid_move) do
    %{game | game_state: :invalid_guess}
  end

  defp accept_guess(game, _guess, _already_used = true) do
    %{game | game_state: :already_used}
  end

  defp accept_guess(game, guess, _already_used) do
    %{game | used: MapSet.put(game.used, guess)}
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp score_guess(game, _good_guess = true) do
    new_state = maybe_won(MapSet.subset?(MapSet.new(game.letters), game.used))
    %{game | game_state: new_state}
  end

  defp score_guess(game = %{turns_left: 1}, _good_guess) do
    %{game | game_state: :lost, turns_left: 0}
  end

  defp score_guess(game, _good_guess) do
    %{game | game_state: :bad_guess, turns_left: game.turns_left - 1}
  end

  defp tally(game) do
    %{
      turns_left: game.turns_left,
      game_state: game.game_state,
      letters: reveal_guessed_letters(game),
      used: game.used |> MapSet.to_list() |> Enum.sort()
    }
  end

  defp return_with_tally(game) do
    {game, tally(game)}
  end

  defp reveal_guessed_letters(game) do
    game.letters
    |> Enum.map(&(MapSet.member?(game.used, &1) |> maybe_reveal(&1)))
  end

  defp maybe_won(true), do: :won
  defp maybe_won(_), do: :good_guess

  defp maybe_reveal(true, letter), do: letter
  defp maybe_reveal(_, _letter), do: "_"

  defp valid_letter?(letter) do
    letter |> String.codepoints() |> length() == 1 && letter =~ ~r/[a-z]/
  end
end
