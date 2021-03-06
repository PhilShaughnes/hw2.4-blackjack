#============================================================
# Added a comment box to blackjack_.rb, card_test.rb, and
# card.rb, then committed
#============================================================
require './card.rb'
require 'minitest/autorun'

class CardTest < MiniTest::Test
  def test_attributes_exist
    assert c(5).suit
    assert c(5).face
    assert c(5).value
  end

  def test_ace_value_11
    assert c('A').value == 11, c('A').value.inspect
  end

  def test_king_value_10
    assert c('K').value == 10
  end

  def test_queen_value_10
    assert c('Q').value == 10
  end

  def test_jack_value_10
    assert c('J').value == 10
  end

  def test_card_compare
    assert c(3) < c(9)
    assert c('K') == c('J')
    assert c(10) == c(10)
  end

  def c(f)
    Card.new(suit: '♦', face: f)
  end
end
