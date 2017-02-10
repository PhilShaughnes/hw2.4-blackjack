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
    play
  end

  def play
    if deal
      # user choice (show user cards/options)
      p1 << deck.draw while p1.inject(:+) < 21 && user_choice
      #computer draws a card if player hasn't busted and <16
      cpu << deck.draw while p1.inject(:+) <= 21 && cpu.inject(:+) < 16
    end
    gameover
  end

  def deal
    2.times do
      p1 << deck.draw
      cpu << deck.draw
    end
    #insta_win if cpu.inject(:+) == 21
    #puts "Computer got BLACKJACK! you lose." if cpu.inject(:+) == 21
  end

  def user_choice
    system 'clear'
    p1cards = p1.map{ |c| "#{c}, "}
    puts p1.inject(:+)
    puts p1cards
    puts "Dealer has #{cpu[0]} 🂠?"
    prompt.select("Hit or Stay?",{hit: true, stay: false})
  end

  def gameover
    puts "computer had:"
    puts cpu
    puts find_winner
    rematch
  end

  def find_winner
    calcscore
    case p1[0] <=> cpu[0]
    when 1 then "you win!"
    when 0 then p1[1] < cpu[1] ? "Computer has more cards, you lose." : "You have more cards, you win"
    when -1 then "Dealer wins. You lose. :("
    end
  end

  def calcscore
    p1.inject(:+) > 21 ? self.p1 = 0
    : self.p1 = [p1.inject(:+), p1.length]
    cpu.inject(:+) > 21 ? self.cpu = 0
    : self.cpu = [cpu.inject(:+), cpu.length]
  end

  def rematch
    Game.new if prompt.yes?("Would you like a rematch?")
  end

end

Game.new
