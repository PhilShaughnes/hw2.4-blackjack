require './card.rb'

class Deck < Array
  def initialize
    Card.suits.each do |s|
      Card.faces.each { |f| self << Card.new(suit: s, face: f) }
    end
    shuffle!
  end

  def draw
    shift
  end
end
