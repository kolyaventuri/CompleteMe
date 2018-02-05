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

      new_node = Node.new(char, store_word)
      current_node.child_nodes[char] = new_node

      insert(chars_array, current_node.child_nodes[char], word) if chars_array.length > 0
    end

    [word]

  end

  def suggest(pattern, list=[], current_node=@head)

    unless pattern.instance_of? Array
      return suggest(pattern.chars, list, current_node)
    end

    char = pattern.shift

    if current_node.word
      list.push(current_node.word)
    end

    if current_node.child_nodes[char]
      suggest(pattern, list, current_node.child_nodes[char])
    elsif char.nil?
      current_node.child_nodes.values.each do |node|
        suggest(pattern, list, node)
      end
    end

    list
  end

  def populate(words)
    words.each do |word|
      insert(word)
    end
  end

end