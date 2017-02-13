require_relative 'player'

class Dealer < Player

  def choice
    if hand.any?{ |c| c.face == 'A' }
      hand.inject(:+) < 18
    else
      hand.inject(:+) < 16
    end
  end

  def hide
    "#{hand[0]}#{color.cyan("🂠")}#{color.red("?")}"
  end

end
