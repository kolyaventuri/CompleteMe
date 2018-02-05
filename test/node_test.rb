require 'minitest/autorun'
require 'minitest/pride'
require './lib/node.rb'

class NodeTest < Minitest::Test
  def test_node_is_created
    node = Node.new('a')

    assert_equal 'a', node.character

    assert_equal Hash.new, node.child_nodes

    assert_equal Hash.new, node.weight

    refute node.word
  end
end