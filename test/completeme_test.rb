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
    assert_equal ['a', 'aardvark', 'pizza'], completion.suggest('a').sort
    assert_equal ['pizza', 'xylophones'], completion.suggest('p').sort
    assert_equal [], completion.suggest('c')
  end

  def test_suggest_works_properly
    completion = CompleteMe.new
    dictionary = File.read('./data/words.505.txt')

    completion.populate(dictionary)
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

    assert_equal ['a', 'aardvark', 'pizza'], completion.suggest('a').sort
    completion.delete('aardvark')
    assert_equal ['a', 'pizza'], completion.suggest('a').sort
    completion.delete('a')
    assert_equal ['pizza'], completion.suggest('a').sort
    assert_equal ['pizza', 'xylophones', 'zombies'], completion.suggest('').sort
  end

  def test_loads_addresses
    expected_addr1 = ['4950 N Dahlia St',
                      '4950 N Decatur St',
                      '4950 N Dillon St',
                      '4950 N Durham Ct']

    expected_addr2 = ['1922 S Michigan Way']

    completion = CompleteMe.new
    addresses = File.read('./data/addresses.csv')

    addresses = addresses.split("\n")
    addresses.shift

    final_addr_array = addresses.map do |addr|
      addr.split(',').last
    end

    final_addr_list = final_addr_array.join("\n")

    completion.populate(final_addr_list)
    assert_equal expected_addr1, completion.suggest('4950 N D').sort
    assert_equal expected_addr2, completion.suggest('1922 S Mi')
    assert_equal [], completion.suggest('666 H')
  end

  def test_finds_substrings
    completion = CompleteMe.new
    dictionary = File.read('./data/words.sub.txt')

    expected = ['communicate', 'complete', 'incomplete']

    completion.populate(dictionary)
    assert_equal expected, completion.suggest('com').sort
  end
end
