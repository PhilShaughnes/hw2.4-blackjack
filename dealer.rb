require_relative 'player'
require 'pry'


class Dealer < Player

  def choice
    hand.inject(:+) < 16
  end

  def hide
    "#{hand[0]}#{color.cyan("🂠")}#{color.red("?")}"
  end

end

#binding pry
