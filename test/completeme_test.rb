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

  def test_populate_accepts_files
    skip
    completion = CompleteMe.new
    completion.populate(['a','b','c'])
    assert 'a', dictionary.include?
    assert 'b', dictionary.include?
    assert 'c', dictionary.include?

  end

  def test_insert_accepts_strings
    skip
    completion = CompleteMe.new
    completion.insert('word')
    assert 'word', dictionary.include?
  end

  def test_insert_increases_count
    skip
    completion = CompleteMe.new
    assert_equal 0, dictionary.length
    completion.insert('word')
    assert_equal 1, dictionary.length
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
