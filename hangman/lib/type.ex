defmodule Hangman.Type do
  @type state ::
          :initializing
          | :not_initialized
          | :won
          | :lost
          | :good_guess
          | :bad_guess
          | :invalid_guess
          | :already_used

  @type tally :: %{
          turns_left: integer(),
          game_state: state,
          letters: list(String.t()),
          used: list(String.t())
        }
end
