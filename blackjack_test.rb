#============================================================
# Added a comment box to blackjack_test.rb and then commited
#
#
#============================================================s

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

  def test_drawall
    @g.cpu.hand << c(3)
    @g.cpu.hand << c(5)
    @g.cpu.hand << c(7)
    @g.p1.hand << c(10)
    @g.p1.hand << c(5)
    @g.p1.hands[1] = []
    @g.p1.hand(1) << c(3)
    @g.p1.hand(1) << c(5)
    @g.p1.hand(1) << c(7)
    @g.drawall(@g.cpu.show)
  end

  def test_split
    @g.cpu.hand << c(3)
    @g.cpu.hand << c(5)
    @g.cpu.hand << c(7)
    @g.p1.hand << c(6)
    @g.p1.hand << c(6)
    #@g.play
  end


  def c(v)
     @g.deck.find{ |c| c.value == v}
  end

end
