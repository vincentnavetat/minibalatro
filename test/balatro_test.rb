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

  def test_play
    fake_input = StringIO.new("1\n")
    $stdin = fake_input

    expected_output = <<OUTPUT
Here are your cards: H9 S10 D5 H2 H5 S2 C1
You have a high card and scored 0
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
