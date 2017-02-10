require_relative 'deck'
require 'tty'
require 'pry'

class Game
  attr_accessor :deck,
                :p1,
                :cpu,
                :prompt

  def initialize
    @deck = Deck.new
    @prompt = TTY::Prompt.new
    @p1 = []
    @cpu = []
  end

  def playhand
    # deal cards
    deal
    # user choice (show user cards/options)
    p1 << deck.draw while p1.inject(:+) < 21 && user_choice
    #computer draws a card if player hasn't busted and <16
    cpu << deck.draw while p1.inject(:+) <= 21 && cpu.inject(:+) < 16
    #  calculate value

    # compare values & declare winner
    gameover
  end

  def deal
    2.times do
      p1 << deck.draw
      cpu << deck.draw
    end
    #insta_win if cpu.inject(:+) == 21
  end

  def user_choice
    p1cards = p1.map{ |c| "#{c}, "}
    puts p1.inject(:+)
    puts p1cards
    puts "Dealer has #{cpu[0]}"
    prompt.select("Hit or Stay?",{hit: true, stay: false})
  end

  def gameover
    puts "computer had:"
    puts cpu
    check_bust
    puts find_winner
  end

  def find_winner
    case p1.inject(:+) <=> cpu.inject(:+)
    when 1 then "you win!"
    when 0 then "Tie. You still win!"
    when -1 then "Dealer wins. You lose. :("
    end
  end

  def check_bust
    p1.inject(:+) > 21 ? self.p1 = 0 : self.p1 = p1.inject(:+)
    cpu.inject(:+) > 21 ? self.cpu = 0 : self.cpu = cpu.inject(:+)
  end

end

game = Game.new
binding pry
