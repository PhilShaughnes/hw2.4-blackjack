require 'minitest/autorun'
require './player'
require './dealer'
require './deck.rb'
require 'pry'


class PlayerTest < MiniTest::Test

  def setup
    @deck = Deck.new
    @p1 = Player.new
    @d = Dealer.new
  end

  def test_dealer_choice
    @p1.hand << c(8)
    puts @p1.inspect
    binding pry
  end


  def c(v)
     @deck.find{ |c| c.value == v}
  end

end
