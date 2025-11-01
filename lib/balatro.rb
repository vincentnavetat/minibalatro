require 'pry'

class Deck
  attr_reader :cards
  extend Forwardable
  def_delegators :@cards, :size, :shift
  include Enumerable

  def initialize
    @cards = ["H", "D", "C", "S"]
      .map { |colour| [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map { |number| "#{colour}#{number}" } }
      .flatten!
      .shuffle
  end
end

class Balatro
  attr_reader :deck, :hand

  HAND_SIZE = 7

  def initialize
    @deck = Deck.new
    @hand = pick_hand
  end

  def play
    puts "Here are your cards: #{show_hand}"
    # number = STDIN.gets.chomp.to_i
    # puts "You have a high card"
  end

  private

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

Balatro.new.play
