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
    is_word = chars_array.length.zero?

    store_word = nil
    store_word = word if is_word
    
    new_node = Node.new(char, store_word)
    current_node.child_nodes[char] = new_node

    insert(chars_array, current_node.child_nodes[char], word) if chars_array.length > 0

    [word]
  end

  def suggest(pattern)

  end

  def populate(words)

  end

end