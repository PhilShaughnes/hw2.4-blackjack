
class Card
  include Comparable

  def self.faces
    Array(2..10) + %w(J Q K A)
  end

  def self.suits
    %w(Hearts Diamonds Clubs Spades)
  end

  attr_accessor :face, :value, :suit

  def initialize(suit:, face:)
    @face = face
    @suit = suit
    @value = self.class.faces.index(face) + 2
  end

  def <=>(other)
    other.is_a?(Card) ? value <=> other.value : super(other)
  end



  # def setvalue
  #   self.value = case
  #               when face.to_i > 1 then face.to_i
  #               when face == 'J' then 11
  #               when face == 'Q' then 12
  #               when face == 'K' then 13
  #               when face == 'A' then 14
  #               end
  # end
end
