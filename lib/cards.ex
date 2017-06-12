defmodule Cards do
  @moduledoc """
    Methods for handling and create decks of cards.
  """

  @doc """
    Returns a deck of cards
  """
  def create_deck do
    numbers = ["1", "2", "3", "4", "5", "6", "7"]
    colors = ["red", "orange", "yellow", "green", "skyblue", "blue", "violet"]
    for color <- colors, number <- numbers do
      "#{number}_#{color}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(cards, card) do
    Enum.member?(cards, card)
  end

  # TODO: This didn't work out, need to ask about it
  # def deal_hands(hands, deck, hand_size, players) do
  #   combinator = &Cards.deal_hands(hands + elem(&1, 0) , elem(&1, 1), hand_size, players - 1)
  #   case players do
  #     0 -> {hands, deck}
  #     _ -> Enum.split(deck, hand_size) |> combinator
  #   end
  # end

  @doc """
    Divides the deck into [hand | deck] based on hand_size.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["1_red"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  def start_game(filename, hand_size) do
    Cards.load(filename)
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
