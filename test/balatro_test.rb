gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/balatro'

class BalatroTest < Minitest::Test
  def test_play
    expected = "Here are your cards: H1 H2 H3 H4 H5 H6 H7"
    assert_equal(
      expected,
      Balatro.new().play())
  end

  def test_deck_size
    assert_equal(
      33,
      Balatro.new().deck.size)
  end
end
