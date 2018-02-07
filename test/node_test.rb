require_relative 'test_helper'
require './lib/node.rb'

class NodeTest < Minitest::Test
  def test_node_is_created
    node = Node.new('a')

    assert_equal 'a', node.character

    assert_equal Hash.new, node.child_nodes

    assert_equal [], node.weights

    refute node.word
  end
end
