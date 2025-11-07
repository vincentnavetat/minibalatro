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
You have a pair and scored 0
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
    assert_equal("high card", Figure.new([Card.new("D", 2), Card.new("H", 3)]).to_s)
  end

  def test_pair
    assert_equal("pair", Figure.new([Card.new("D", 2), Card.new("H", 2)]).to_s)
  end

  def test_double_pair
    assert_equal("double pair", Figure.new([Card.new("D", 2), Card.new("H", 2), Card.new("C", 3), Card.new("S", 3)]).to_s)
  end
end
