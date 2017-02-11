require_relative 'deck'
#require_relative 'player'
require 'tty'
require 'pry'

# TODO:
# 1) make interface better
# 2) 6 cards and under 21 is automatic win
# 3) test ties handling
# 4) test insta_win

class Game
  attr_accessor :deck,
                :p1,
                :cpu,
                :prompt,
                :color

  def initialize
    @color = Pastel.new
    @deck = Deck.new
    @prompt = TTY::Prompt.new
    @p1 = []
    @cpu = []
  end

  def play
    if deal
      # user choice (show user cards/options)
      p1 << deck.draw while p1.inject(:+) < 21 && user_choice
      # computer draws a card if player hasn't busted and <16
      cpu << deck.draw while p1.inject(:+) <= 21 && cpu.inject(:+) < 16
    else
      'Computer got BLACKJACK! you lose.'
    end
    gameover
    rematch
  end

  def deal
    2.times do
      p1 << deck.draw
      cpu << deck.draw
    end
    cpu.inject(:+) != 21
  end

  def user_choice
    system 'clear'
    p1cards = p1.map { |c| "#{c}, " }
    puts p1.inject(:+)
    puts p1cards
    puts "Dealer has #{cpu[0]} #{color.cyan("🂠")}#{color.red("?")}"
    prompt.select('Hit or Stay?', hit: true, stay: false)
  end

  def gameover
    puts 'computer had:'
    puts cpu
    puts find_winner
  end

  def find_winner
    # check for 6 cards and under 21
    # if player, they win, if computer, they win
    if p1.length >= 6
       "more than 5 cards! you win!"
    else
      self.p1 = calcscore(p1)
      self.cpu = calcscore(cpu)
      case p1[0] <=> cpu[0]
      when 1 then 'you win!'
      when 0 then tie
      when -1 then 'Dealer wins. You lose. :('
      end
    end

  end

  def tie
    p1[1] < cpu[1] ? 'Computer has more cards, you lose.'
                    : 'You win the tie!'
  end

  def calcscore(player)
    #player = (player.inject(:+) > 21 ? 0 : [player.inject(:+), player.length])
    player.inject(:+) > 21 ? 0 : [player.inject(:+), player.length]

  end

  def rematch
    Game.new.play if prompt.yes?('Would you like a rematch?')
  end
end

Game.new.play
