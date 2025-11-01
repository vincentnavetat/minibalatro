gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/balatro'

class BalatroTest < Minitest::Test
  def test_game
    expected = "Here are your cards: H1"
    assert_equal(
      expected,
      Balatro.new().play())
  end
end
