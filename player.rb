require 'tty'
require 'pry'

class Player
  attr_accessor :color, :hand, :split

  def initialize
    @color = pastel.new
    @hand = []
    @split = false
  end

  def choice

  end

  def ace

  end

  def score

  end

  def to_s

  end

end



# def user_choice
#   system 'clear'
#   p1cards = p1.map { |c| "#{c}, " }
#   puts p1.inject(:+)
#   puts pastel.cyan(p1cards)
#   puts "Dealer has #{cpu[0]} #{pastel.red('🂠?')}"
#   prompt.select('Hit or Stay?', hit: true, stay: false)
# end
#
#
# def calcscore(player)
#   #player = (player.inject(:+) > 21 ? 0 : [player.inject(:+), player.length])
#   player.inject(:+) > 21 ? 0 : [player.inject(:+), player.length]
#
# end
