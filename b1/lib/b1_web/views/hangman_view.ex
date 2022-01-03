defmodule B1Web.HangmanView do
  use B1Web, :view

  @status_fields %{
    initializing: {"initiliazing", "Guess the word, a letter a a time"},
    not_initialized: {"not-initialized", "Sorry, the game wasn't initialized properly"},
    good_guess: {"good-guess", "Good guess!"},
    bad_guess: {"bad-guess", "Sorry, that's a bad guess"},
    invalid_guess: {"invalid-guess", "Sorry, that's an invalid guess"},
    won: {"won", "You won!"},
    lost: {"lost", "Sorry, you lost"},
    already_used: {"already-used", "You already used that letter"}
  }

  def move_status(status) do
    {class, msg} = @status_fields[status]
    "<div class='status #{class}'>#{msg}</div>" |> raw()
  end

  def continue_or_try_again(conn, status) when status in [:won, :lost, :not_initialized] do
    button("Try again", to: Routes.hangman_path(conn, :new))
  end

  def continue_or_try_again(conn, _) do
    form_for(conn, Routes.hangman_path(conn,  :update), [ as: "make_move", method: :put ], fn f ->
      [
        text_input(f, :guess, class: "form-control"),
        " ",
        submit("Make next guess"),
      ]
   end)
 end

  def figure_for(0) do
    ~s{
      ┌───┐
      │   │
      O   │
     /|\\  │
     / \\  │
          │
    ══════╧══
    }
  end

  def figure_for(1) do
    ~s{
      ┌───┐
      │   │
      O   │
     /|\\  │
     /    │
          │
    ══════╧══
    }
  end

  def figure_for(2) do
    ~s{
      ┌───┐
      │   │
      O   │
     /|\\  │
          │
          │
    ══════╧══
    }
  end

  def figure_for(3) do
    ~s{
      ┌───┐
      │   │
      O   │
     /|   │
          │
          │
    ══════╧══
    }
  end

  def figure_for(4) do
    ~s{
      ┌───┐
      │   │
      O   │
      |   │
          │
          │
    ══════╧══
    }
  end

  def figure_for(5) do
    ~s{
      ┌───┐
      │   │
      O   │
          │
          │
          │
    ══════╧══
    }
  end

  def figure_for(6) do
    ~s{
      ┌───┐
      │   │
          │
          │
          │
          │
    ══════╧══
    }
  end

  def figure_for(7) do
    ~s{
      ┌───┐
          │
          │
          │
          │
          │
    ══════╧══
    }
  end
end
