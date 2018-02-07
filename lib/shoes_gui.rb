require_relative 'complete_me'

Shoes.app :title => "Autocompleteratorizer" do
  @completion = CompleteMe.new
  @dictionary = '../data/words.505.txt'
  background silver .. blue
  border(rgb(64, 224, 208), strokewidth: 8)

  title "     Free-style Rap Assistant"

  stack(margin: 12) do
    
    para "First, add a dictionary! (You can add your own rap dictionary)"
    flow do
      @new_dictionary = edit_line(@dictionary)
      @dictionary_button = button("Add that dictionary")
      @dictionary_button.click do
        dictionary = File.read(@new_dictionary.text)
        @completion.populate(dictionary)
        @dictionary_added.replace("Your dictionary has been added!")
      end
    end
    @dictionary_added = para ''

    para "Having trouble finding the words?"
    flow do
      @substring = edit_line
      @sub_button = button "Get those words"
      @sub_button.click do
        @completed_words.replace(@completion.suggest(@substring.text).join(', '))
      end
    end
      @completed_words = para ''

    para "Want to see a word more often?"
    flow do
      @selected_word = edit_line
      @select_button = button("Select that word")
      @select_button.click do
        @selection.replace(@completion.select(@selected_word.text, @substring.text).join(', '))
      end
    end
      @selection = para ''

    para "Want to add a word?"
    flow do
      @inserted_word = edit_line
      @insert_button = button("Insert that word")
      @insert_button.click do
        @insertion.replace(@completion.insert(@inserted_word.text).join(', '))
      end
    end
    @insertion= para ''

    para "Want to delete a word?"
    flow do
      @word_to_delete = edit_line
      @delete_button = button("Delete that word")
      @delete_button.click do
        @deleted_word.replace(@completion.insert(@word_to_delete.text).join(', '))
      end
    end
    @deleted_word = para ''

  end
end
