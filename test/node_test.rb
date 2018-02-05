require 'minitest/autorun'
require 'minitest/pride'
require './lib/node.rb'
require 'pry'

class NodeTest < Minitest::Test
  def test_node_is_created
    node = Node.new('a')

    assert_equal 'a', node.character

    refute node.child_nodes

    assert_equal 0, node.weight
    
    refute node.word
  end
end
