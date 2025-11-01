require 'pry'

class Balatro
  attr_reader :deck, :hand

  HAND_SIZE = 7

  def initialize
    @deck = initialize_deck
    @hand = pick_hand
  end

  def play
    "Here are your cards: #{show_hand}"
  end

  private

  def initialize_deck
    ["H", "D", "C", "S"]
      .map { |colour| [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map { |number| "#{colour}#{number}" } }
      .flatten!
  end

  def pick_hand
    h = []

    HAND_SIZE.times do
      h.push(deck.shift)
    end

    h
  end

  def show_hand
    hand.join(" ")
  end
end
