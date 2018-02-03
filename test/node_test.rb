require 'minitest/autorun'
require 'minitest/pride'
require './lib/node.rb'
require 'pry'

class NodeTest < Minitest::Test
  def test_node_is_created
    node = Node.new('a')
    assert_equal 'a', node.character
  end

  def test_starts_with_no_children
    node = Node.new('a')
    refute node.child_nodes
  end

  def test_starts_with_no_weight
    node = Node.new('a')
    assert_equal 0, node.weight
  end

  def test_does_not_start_as_word
    node = Node.new('a')
    refute node.word
  end

end
