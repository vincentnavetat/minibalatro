gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/balatro'

class BalatroTest < Minitest::Test
  def setup
    srand(1234)
    @balatro = Balatro.new
  end

  def test_play
    expected = "Here are your cards: H9 S10 D5 H2 H5 S2 C1\n"
    assert_output(expected) { @balatro.play }
  end

  def test_deck_size
    assert_equal(33, @balatro.deck.size)
  end
end
