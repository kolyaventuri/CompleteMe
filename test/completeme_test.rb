require 'minitest/autorun'
require 'minitest/pride'
require './lib/completeme.rb'
require 'pry'

class CompleteMeTest < Minitest::Test

  def test_head_node_starts_empty
    completion = CompleteMe.new
    refute completion.head
  end

  def test_count_starts_empty
    completion = CompleteMe.new
    assert_equal 0, completion.count
  end

  def test_insert_accepts_strings
    completion = CompleteMe.new
    completion.insert('word')
    assert_equal ['word'], completion.suggest('word')
  end

  def test_populate_populates
    completion = CompleteMe.new
    completion.populate(['a' ,'b', 'c'])
    assert_equal ['a'], completion.suggest('a')
    assert_equal ['b'], completion.suggest('a')
    assert_equal ['c'], completion.suggest('a')
  end


  def test_insert_increases_count
    completion = CompleteMe.new
    assert_equal 0, completion.count
    completion.insert('word')
    assert_equal 1, completion.count
  end

  def test_suggest_offers_completed_word_options
    skip
    completion = CompleteMe.new
  end

  def test_select_creates_substring_word_correlation
    skip
    completion = CompleteMe.new
  end
end