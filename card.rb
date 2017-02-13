#============================================================
# Added a comment box to blackjack_.rb, card_test.rb, and
# card.rb, then committed
#============================================================
require 'tty'

class Card
  include Comparable

  def self.faces
    Array(2..10) + %w(J Q K A)
  end

  def self.suits
    %w(♥ ♦ ♣ ♠)
  end

  attr_accessor :face, :value, :suit, :color

  def initialize(suit:, face:)
    @face = face
    @suit = suit
    @value = setvalue
    @color = Pastel.new
  end

  def <=>(other)
    other.is_a?(Card) ? value <=> other.value : super(other)
  end

  def +(other)
    other.is_a?(Card) ? value + other.value : super(other)
  end

  def coerce(other)
    [value, other]
  end

  def to_s
    case suit
    when '♥', '♦' then "#{face}#{color.red(suit)} "
    when '♣', '♠' then "#{color.cyan(face)}#{suit} "
    end
  end

  # def setvalue
  #   self.class.faces.index(face) + 2
  # end

  def setvalue
    self.value = case
                when face.to_i > 1 then face.to_i
                when face == 'A' then 11
                else 10
                end
  end
end
