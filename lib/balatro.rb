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

  MULT = {
    "double pair": 2,
    "pair": 2,
    "high card": 1
  }

  def initialize(cards)
    @name = name_from_cards(cards)
    @score = score_from_cards(cards, name)
  end

  def to_s
    name
  end

  private

  def name_from_cards(cards)
    hash = cards_with_same_number(cards)

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
    hash = cards_with_same_number(cards)

    score = 0
    hash.each do |key, value|
      score += key * value
    end

    score * MULT[name.to_sym]
  end

  def cards_with_same_number(arr)
    counts = Hash.new(0)
    arr.each { |card| counts[card.number] += 1 }
    counts.select { |_, v| v > 1 }
  end
end

class FigureFactory
  def self.figure_for_cards(cards)
    case scoring_cards(cards).size
    when 4
      DoublePair.new(cards)
    when 2
      Pair.new(cards)
    else
      HighCard.new(cards)
    end
  end

  private

  def self.scoring_cards(objects)
    counts = Hash.new(0)
    objects.each { |obj| counts[obj.number] += 1 }

    duplicates = objects.select { |obj| counts[obj.number] >= 2 }

    if duplicates.empty?
      max_obj = objects.max_by { |obj| obj.number }
      max_obj ? [max_obj] : []
    else
      duplicates
    end
  end
end

class FigureTemp
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end
end

class HighCard < FigureTemp
  def score
    cards.first
  end
end

class Pair < FigureTemp
  def score
    10
  end

  def ==(other)
    other.is_a?(Pair) && cards == other.cards
  end
end

class DoublePair < FigureTemp
  def score
    20
  end
end

class Hand
  attr_reader :cards

  SIZE = 7

  def initialize(deck)
    @cards = []

    pick(deck)
  end

  def pick(deck)
    SIZE.times do
      cards.push(deck.shift)
    end
  end

  def show
    cards.join(" ")
  end
end

class Balatro
  attr_reader :deck, :hand

  HAND_SIZE = 7

  def initialize
    @deck = Deck.new
    @hand = Hand.new(deck)
  end

  def play
    puts "Here are your cards: #{hand.show}"
    card_positions = gets.sub! "\n", ""

    played_cards = pick_cards(card_positions)
    played_figure = Figure.new(played_cards)

    # discard all cards

    puts "You have a #{played_figure.to_s} and scored #{played_figure.score}"
  end

  private

  def pick_cards(card_positions)
    card_positions.chars.map { |index| hand.cards[index.to_i] }
  end
end
