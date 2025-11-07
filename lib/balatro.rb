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

class Figure
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def to_s
    raise NotImplementedError
  end

  def multiplier
    raise NotImplementedError
  end

  def score
    raise NotImplementedError
  end
end

class HighCard < Figure
  def to_s
    "high card"
  end

  def multiplier
    1
  end

  def score
    cards.first.number * multiplier
  end

  def ==(other)
    other.is_a?(HighCard) && cards == other.cards
  end
end

class Pair < Figure
  def to_s
    "pair"
  end

  def multiplier
    2
  end

  def score
    score = 0
    cards.each { |card| score += card.number }
    score * multiplier
  end

  def ==(other)
    other.is_a?(Pair) && cards == other.cards
  end
end

class DoublePair < Figure
  def to_s
    "double pair"
  end

  def multiplier
    2
  end

  def score
    score = 0
    cards.each { |card| score += card.number }
    score * multiplier
  end

  def ==(other)
    other.is_a?(DoublePair) && cards == other.cards
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
    played_figure = FigureFactory.figure_for_cards(played_cards)

    # discard all cards

    puts "You have a #{played_figure.to_s} and scored #{played_figure.score}"
  end

  private

  def pick_cards(card_positions)
    card_positions.chars.map { |index| hand.cards[index.to_i] }
  end
end
