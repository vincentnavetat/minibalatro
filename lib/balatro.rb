require 'pry'

class Deck
  attr_reader :cards
  extend Forwardable
  def_delegators :@cards, :size, :shift
  include Enumerable

  def initialize
    @cards = ["H", "D", "C", "S"]
      .map { |colour| [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map { |number| Card.new(colour, number) } }
      .flatten!
      .shuffle
  end
end

class Card
  attr_reader :colour, :number

  def initialize(colour, number)
    @colour = colour
    @number = number
  end

  def to_s
    "#{colour}#{number}"
  end
end

class Figure
  attr_reader :name, :score

  def initialize(cards)
    @name = name_from_cards(cards)
    @score = score_from_cards(cards, name)
  end

  def to_s
    name
  end

  private

  def name_from_cards(cards)
    # hash = repeated_chars(cards)

    case hash.size
    when 2
      "double pair"
    when 1
      "pair"
    else
      "high card"
    end
  end

  def score_from_cards(cards, name)
    # hash = repeated_chars(cards)

    0
  end

  def repeated_chars(str)
    str.map { |c| c[1] }.join


    counts = Hash.new(0)
    str.each_char { |ch| counts[ch] += 1 }
    counts.select { |_, v| v > 1 }.transform_keys(&:to_sym)
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
    number = gets.chomp.to_i

    played_cards = pick_cards(number)
    played_figure = Figure.new(played_cards)

    # discard all cards

    puts "You have a #{played_figure.to_s} and scored #{played_figure.score}"
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

  def pick_cards(number)
    [hand[number]]
  end

  def figure(played_cards)

  end
end
