class Node
  attr_reader :character
  attr_accessor :weight, :child_nodes, :word
  def initialize(character, child_nodes = nil, weight = 0, word = nil)
    @character = character
    @child_nodes = child_nodes
    @weight = weight
    @word = word
  end
end
