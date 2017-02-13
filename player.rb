require 'tty'

class Player
  attr_accessor :color, :split, :hands, :prompt, :wins, :loses, :games

  def initialize
    @color = Pastel.new
    #@split = false
    @prompt = TTY::Prompt.new
    @hands = [[]]
    @wins = 0
    @loses = 0
    @games = 0
  end

  def choice(n = 0)
    puts "ADVICE: #{biased_advisor}"
    prompt.select('Hit or Stay?', hit: true, stay: false)
  end

  def split(n = 0)
    hands[n+1] = []
    hands[n+1] << hands[n].pop
  end

  def total(n = 0)
    hand(n).inject(:+)
  end

  def score(n = 0)
    hand(n).inject(:+) > 21 ? 0 : hand(n).inject(:+)
  end

  def show(n = 0)
    s =""
    hand(n).each{|c| s += "#{c}"}
    s += "\ntotal:#{score(n)}"
  end

  def hand(n = 0)
    hands[n]
  end

  def biased_advisor
    ["HIT that!", "HHHIIIIIITTTT!", "I like that where it is.", "make me a sandwich!", "DON'T MOVE AN INCH!"].sample
  end

end
