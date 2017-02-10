require './deck.rb'
require 'minitest/autorun'

class DeckTest < MiniTest::Test
  def setup
    @deck = Deck.new
  end

  def test_52_cards
    assert @deck.count == 52
    assert @deck.all?{ |c| c.is_a? Card}
  end

  def test_13_of_each_suit
    assert @deck.select { |c| c.suit == '♡' }.count == 13
    assert @deck.select { |c| c.suit == '♢' }.count == 13
    assert @deck.select { |c| c.suit == '♠' }.count == 13
    assert @deck.select { |c| c.suit == '♣' }.count == 13
  end

  def test_four_each_face
    assert @deck.select { |c| c.face == 'J' }.count == 4
    assert @deck.select { |c| c.face == 'Q' }.count == 4
    assert @deck.select { |c| c.face == 'K' }.count == 4
    assert @deck.select { |c| c.face == 'A' }.count == 4
  end

  def test_shuffled
    assert @deck != Deck.new
  end

  def test_draw_card
    assert @deck.draw.class == Card
    assert @deck.count == 51
  end
end
