require 'tty'


class Player
  attr_accessor :color, :split, :hands, :prompt

  def initialize
    @color = Pastel.new
    #@split = false
    @prompt = TTY::Prompt.new
    @hands = [[]]
  end

  def choice(n = 0)
    #system 'clear'
    hand(n).each{ |c| print c }
    puts "total: #{hand(n).inject(:+)}"
    prompt.select('Hit or Stay?', hit: true, stay: false)
  end

  def split(n = 0)
    hands[n+1] = []
    hands[n+1] << hands[n].pop
  end

  def ace

  end

  def score(n = 0)
    hand(n).inject(:+) > 21 ? 0 : hand(n).inject(:+)
  end

  def show(n = 0)
    s ="#{score(n)}: "
    hand(n).each{|c| s += "#{c}"}
    s
  end

  def hand(n = 0)
    hands[n]
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
