require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me.rb'
require './lib/node.rb'
require 'pry'

class CompleteMeTest < Minitest::Test

  def test_head_node_starts_empty
    completion = CompleteMe.new
    assert_instance_of Node, completion.head
    assert_nil completion.head.character
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
    dictionary = File.read('./data/words.sample.txt')
    completion.populate(dictionary)
    assert_equal ['a', 'aardvark'], completion.suggest('a')
    assert_equal ['pizza'], completion.suggest('p')
    assert_equal [], completion.suggest('c')
  end

  def test_suggest_works_properly
    completion = CompleteMe.new
    dictionary = File.read('./data/words.505.txt')

    completion.populate(dictionary)
    # binding.pry
    completion.suggest('piz')
  end
  def test_insert_increases_count
    completion = CompleteMe.new
    assert_equal 0, completion.count
    completion.insert('word')
    assert_equal 1, completion.count
  end

  def test_select_creates_substring_word_correlation
    completion = CompleteMe.new
    dictionary = File.read('./data/words.505.txt')

    completion.populate(dictionary)
    completion.select('piz', 'pizzeria')

    results = completion.suggest('piz')

    assert_equal 'pizzeria', results[0]
  end

  def test_deletes_words
    completion = CompleteMe.new
    dictionary = File.read('./data/words.sample.txt')

    completion.populate(dictionary)

    assert_equal ['a', 'aardvark'], completion.suggest('a')
    completion.delete('aardvark')
    assert_equal ['a'], completion.suggest('a')
    completion.delete('a')
    assert_equal [], completion.suggest('a')
    binding.pry
    assert_equal ['pizza', 'xylophones', 'zombies'], completion.suggest('').sort
  end
end
