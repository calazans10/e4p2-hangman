defmodule Dictionary.Impl.WordListTest do
  use ExUnit.Case
  alias Dictionary.Impl.WordList

  describe "word_list/0" do
    test "returns a word list" do
      word_list = WordList.word_list()
      assert length(word_list) > 0
    end
  end

  describe "random_word/1" do
    test "returns a random word" do
      word_list = ["wombat"]
      assert WordList.random_word(word_list) == "wombat"
    end
  end
end
