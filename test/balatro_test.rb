gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/balatro'

class BalatroTest < Minitest::Test
  def test_play
    expected = "Here are your cards: H1"
    assert_equal(
      expected,
      Balatro.new().play())
  end

  def test_deck_size
    assert_equal(
      39,
      Balatro.new().deck.size)
  end
end
