defmodule Dictionary.Runtime.Server do
  @type t :: pid()

  use Agent

  alias Dictionary.Impl.WordList

  @spec start_link(any) :: {:ok, t}
  def start_link(_) do
    Agent.start_link(&WordList.word_list/0, name: __MODULE__)
  end

  @spec random_word() :: String.t()
  def random_word() do
    Agent.get(__MODULE__, &WordList.random_word/1)
  end
end
