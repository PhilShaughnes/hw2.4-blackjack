require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require 'tty'
require 'pry'


# TODO:
# 1) splitting
# 2) ace can be 1 or 11
# 3) track score
# 4) shoe
# 5) advisor
# 6) tests

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
    @p1 = Player.new
    @cpu = Dealer.new
  end

  def draw(cpuview)
    system 'clear'
    printf("%10s\n", "Dealer")
    printf("%30s\n", cpuview)
    print "\n\n\n"
    (0...p1.hands.length).each do |handnum|
      printf("%15s \n", p1.show(handnum))
    end
    printf("%10s \n", "Player")
  end

  def play(n = 0)
    if deal
      playerturn
      cputurn
    else
      'Computer got BLACKJACK! you lose.'
    end
    gameover
    rematch
  end

  def deal(n = 0)
    #only deal cards if until there are 2 in each hand
    p1.hand(n) << deck.draw while p1.hand(n).length < 2
    cpu.hand << deck.draw while cpu.hand.length < 2
    #check for computer BLACKJACK and split
    cpu.hand.inject(:+) != 21 && split(n)
  end

  def split(n = 0)
    if p1.hand[0] == p1.hand[1]
      #split cards into 2 arrays
      p1.split(n)
      #deal cards to each
      deal(n)
      deal(n+1)
      #play out the players hand
      playerturn(n+1)
    end
    true
  end

  def playerturn(n = 0)
    # user choice (show user cards/options)
    p1.hand(n) << deck.draw while p1.hand(n).inject(:+) < 21 && display_choice
  end

  def cputurn
    # computer draws a card if player hasn't busted and <16
    cpu.hand << deck.draw while p1.hands.any?{|hand| hand.inject(:+) <= 21}  && cpu.choice
  end

  def display_choice(n = 0)
    system 'clear'
    #p1.map { |c| "#{c}" }
    puts "Dealer has #{cpu.hand[0]}#{color.cyan("🂠")}#{color.red("?")}"
    p1.choice(n)
  end

  def gameover(n = 0)
    system 'clear'
    puts "computer had #{cpu.hand.inject(:+)}:"
    cpu.hand.each{ |x| print x}
    puts "\nyou had #{p1.hand.inject(:+)}:"
    p1.hand(n).each{ |x| print x}
    #print "\n"
    puts "\n#{find_winner}"
  end

  def find_winner(n = 0)
    # check for 6 cards and under 21
    # if player, they win, if computer, they win
    if p1.hand.length >= 6
       "more than 5 cards! you win!"
    else
      case p1.score(n) <=> cpu.score
      when 1 then 'you win!'
      when 0 then tie
      when -1 then 'Dealer wins. You lose. :('
      end
    end

  end

  def tie
    p1.hand.length < cpu.hand.length ? 'Computer has more cards, you lose.'
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
#binding pry
Game.new.play
