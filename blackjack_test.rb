require './blackjack.rb'
require 'minitest/autorun'
require 'pry'

class BlackjackTest < MiniTest::Test

  def setup
    @g = Game.new

  end

  def test_tie_handler
    @g.cpu.hand << c(3)
    @g.cpu.hand << c(5)
    @g.cpu.hand << c(7)
    @g.p1.hand << c(10)
    @g.p1.hand << c(5)
    assert 'Computer has more cards, you lose.', @g.find_winner
  end

  def test_tie_with_tied_card_number
    @g.p1.hand << c(10)
    @g.p1.hand << c(5)
    @g.cpu.hand << c(10)
    @g.cpu.hand << c(5)
    assert_equal "You win the tie!", @g.find_winner
  end

  def test_6_cards_win
    @g.p1.hand << c(2)
    @g.p1.hand << c(2)
    @g.p1.hand << c(2)
    @g.p1.hand << c(2)
    @g.p1.hand << c(3)
    @g.p1.hand << c(3)
    @g.cpu.hand << c(9)
    @g.cpu.hand << c(9)
    #@g.calcscore(@g.p1)
    #binding pry
    assert_equal "more than 5 cards! you win!", @g.find_winner

  end

  def test_draw
    @g.cpu.hand << c(3)
    @g.cpu.hand << c(5)
    @g.cpu.hand << c(7)
    @g.p1.hand << c(10)
    @g.p1.hand << c(5)
    @g.p1.hands[1] = []
    @g.p1.hand(1) << c(3)
    @g.p1.hand(1) << c(5)
    @g.p1.hand(1) << c(7)
    @g.draw(@g.cpu.show)

  end

  def c(v)
     @g.deck.find{ |c| c.value == v}
  end

end
