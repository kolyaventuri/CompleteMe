require_relative 'node'
require 'pry'

class CompleteMe
  attr_reader :head,
              :count

  def initialize
    @head = Node.new(nil)
    @count = 0
  end

  def insert(chars_array, current_node=@head, word=nil)
    unless chars_array.instance_of? Array
      return insert(chars_array.chars, current_node, chars_array)
    end

    char = chars_array.shift

    if current_node.child_nodes[char]
      insert(chars_array, current_node.child_nodes[char], word)
    else
      is_word = chars_array.length.zero?

      store_word = nil
      store_word = word if is_word

      @count += 1 if is_word
      if char.nil?
        current_node.word = store_word
      else
        new_node = Node.new(char, store_word)
        current_node.child_nodes[char] = new_node

        insert(chars_array, current_node.child_nodes[char], word) if chars_array.length > 0
      end

    end

    [word]

  end

  def suggest(pattern)
    list = get_suggestions(pattern)
    weights = get_weights(pattern)

    sorted_weight = weights.sort_by { |hash| hash[:weight] }

    until sorted_weight.length.zero?
      to_add = sorted_weight.shift[:word]
      list.delete(to_add) if list.include?(to_add)

      list.unshift(to_add)
    end

    list
  end

  def get_suggestions(pattern, list = [], current_node = @head)
    unless pattern.instance_of? Array
      return get_suggestions(pattern.chars, list, current_node)
    end

    char = pattern.shift

    if current_node.word && char.nil?
      list.push(current_node.word)
    end

    if current_node.child_nodes[char]
      get_suggestions(pattern, list, current_node.child_nodes[char])
    elsif char.nil?
      current_node.child_nodes.values.each do |node|
        get_suggestions(pattern, list, node)
      end
    end

    list
  end

  def get_weights(pattern, current_node = @head)
    unless pattern.instance_of? Array
      return get_weights(pattern.chars, current_node)
    end

    char = pattern.shift

    if current_node.child_nodes[char]
      get_weights(pattern, current_node.child_nodes[char])
    elsif char.nil?
      current_node.weights
    else
      {}
    end
  end

  def populate(dictionary)
    words = dictionary.split("\n")
    words.each do |word|
      word = word.strip
      continue if word.length.zero?
      insert(word)
    end
  end

  def select(substring, selected_word, current_node = @head)
    unless substring.instance_of? Array
      return select(substring.chars, selected_word, current_node)
    end

    char = substring.shift

    if current_node.child_nodes[char]
      select(substring, selected_word, current_node.child_nodes[char])
    elsif char.nil?
      index = nil
      current_node.weights.each_with_index do |weight, current_index|
        if weight.word == selected_word
          index = current_index
          break
        end
      end

      if index.nil?
        current_node.weights.push(word: selected_word, weight: 1)
      else
        current_node.weights[index][:weight] += 1
      end
    end
  end
end
