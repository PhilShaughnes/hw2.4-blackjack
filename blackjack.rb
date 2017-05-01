#============================================================
# Added a comment box to blackjack_.rb, card_test.rb, and
# card.rb, then committed
#============================================================
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require 'tty'


class Game
  attr_accessor :deck,
                :p1,
                :cpu,
                :prompt,
                :color

  def initialize
    @color = Pastel.new
    @deck = Deck.new*6
    @prompt = TTY::Prompt.new
    @p1 = Player.new
    @cpu = Dealer.new
  end

  def drawall(cpuview)
    system 'clear'
    printf("%10s\n", 'Dealer')
    printf("%30s\n", cpuview)
    print "\n"
    printf("%10s \n", 'Player')
    (0...p1.hands.length).each do |handnum|
      printf("%15s \n", p1.show(handnum))
    end
  end

  def draw(n)
    system 'clear'
    printf("%10s\n", 'Dealer')
    printf("%30s\n", cpu.hide)
    print "\n\n"
    printf("%10s \n", 'Player')
    printf("%15s \n", p1.show(n))
  end

  def play(_n = 0)
    p1.games += 1
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
    # only deal cards if until there are 2 in each hand
    p1.hand(n) << deck.draw while p1.hand(n).length < 2
    cpu.hand << deck.draw while cpu.hand.length < 2
    # check for computer BLACKJACK and split
    cpu.total != 21 && split(n)
  end

  def split(n = 0)
    if p1.hand(n)[0] == p1.hand(n)[1]
      draw(n)
      if prompt.yes?('split?')
        # split cards into 2 arrays
        p1.split(n)
        # deal cards to each
        deal(n)
        deal(n + 1)
        drawall(cpu.hide)
        # play out the players hand
        playerturn(n + 1)
      end
    end
    true
  end

  def playerturn(n = 0)
    # user choice (show user cards/options)

    p1.hand(n) << deck.draw while ace_check(p1.hand(n)) && p1.total(n) < 21 && display_choice(n)
  end

  def cputurn
    # computer draws a card if player hasn't busted and <16

    cpu.hand << deck.draw while ace_check(cpu.hand) && p1.hands.any? { |hand| hand.inject(:+) <= 21 } && cpu.choice
  end

  def display_choice(n = 0)
    draw(n)
    p1.choice(n)
  end

  def ace_check(playerhand)
    if playerhand.any?{ |c| c.face == 'A' }
      a = playerhand[playerhand.index{ |c| c.face == 'A'}]
      a.value = 11
      a.value = 1 if playerhand.inject(:+) > 21
    end
    true
  end

  def gameover(_n = 0)
    drawall(cpu.show)
    (0...p1.hands.length).each do |hand|
      puts "#{hand + 1}: #{find_winner(hand)}"
    end
    puts "wins:#{p1.wins} loses:#{p1.loses} games:#{p1.games}"
  end

  def find_winner(n = 0)
    # check for 6 cards and under 21
    # if player, they win, if computer, they win
    if p1.hand.length >= 6
      'more than 5 cards! you win!'
    else
      case p1.score(n) <=> cpu.score
      when 1
        p1.wins += 1
        'you win!'
      when 0 then tie
      when -1
        p1.loses += 1
        'Dealer wins. You lose. :('
      end
    end
  end

  def tie
    if p1.hand.length < cpu.hand.length
      p1.loses += 1
      'Computer has more cards, you lose.'
    else
      p1.wins += 1
      'You win the tie!'
    end
  end

  def rematch
    if prompt.yes?('Would you like a rematch?')
      self.deck = Deck.new*6
      p1.hands = [[]]
      cpu.hands = [[]]
      play
    end
  end
end
#binding pry
Game.new.play
