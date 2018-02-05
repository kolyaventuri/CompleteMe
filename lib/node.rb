class Node
  attr_reader :character
  attr_accessor :weight, :child_nodes, :word

  def initialize(character, word = nil)
    @character = character
    @word = word
    @child_nodes = Hash.new
    @weight = Hash.new
  end
end
