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
    expected = "Here are your cards: D10 S10 D3 C7 D7 C8 S2\n"
    assert_output(expected) { @balatro.play }
  end

  def test_deck_size
    assert_equal(33, @balatro.deck.size)
  end
end
