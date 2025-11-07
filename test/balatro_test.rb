gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require 'minitest/pride'
require 'stringio'
require_relative '../lib/balatro'

class BalatroTest < Minitest::Test
  def setup
    srand(1234)
    @balatro = Balatro.new
  end

  def test_play_pair
    fake_input = StringIO.new("24\n")
    $stdin = fake_input

    expected_output = <<OUTPUT
Here are your cards: H9 S10 D5 H2 H5 S2 C1
You have a pair and scored 20
OUTPUT

    assert_output(expected_output) do
      @balatro.play
    end
  ensure
    $stdin = STDIN
  end

  def test_deck_size
    assert_equal(33, @balatro.deck.size)
  end
end

class FigureTest < Minitest::Test
  def test_high_card
    high_card = Figure.new([Card.new("D", 2), Card.new("H", 3)])
    assert_equal("high card", high_card.to_s)

    # TODO: fix score to match highest card
    assert_equal(0, high_card.score)
  end

  def test_pair
    pair = Figure.new([Card.new("D", 2), Card.new("H", 2)])
    assert_equal("pair", pair.to_s)
    assert_equal(8, pair.score)
  end

  def test_double_pair
    double_pair = Figure.new([Card.new("D", 2), Card.new("H", 2), Card.new("C", 3), Card.new("S", 3)])
    assert_equal("double pair", double_pair.to_s)
    assert_equal(20, double_pair.score)
  end
end

class CardTest < Minitest::Test
  def test_card
    assert_equal("D2", Card.new("D", 2).to_s)
  end
end

class FigureFactoryTest < Minitest::Test
  def test_pair
    card_d2 = Card.new("D", 2)
    card_h2 = Card.new("H", 2)
    assert_equal(Pair.new([card_d2, card_h2]), FigureFactory.figure_for_cards([card_d2, card_h2]))
  end
end
