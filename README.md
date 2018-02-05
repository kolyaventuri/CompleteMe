# Autocomplete

In order to create a functioning Auto Complete we will need two classes: Node and CompleteMe.

## Node
  The node should be created as a single character. It will have 3 attributes: child_nodes, weight, and word.

  - child_nodes will be a hash of {'character' => child_nodes} and will start as a nil value.

  - weight will be used as a ranking system to show the most likely auto complete option based on current node user is on and will start at 0

  - word will identify if a given node completes a word and what that word is, it will start as a nil value

## CompleteMe
  the completeme class will have 2 attributes. a head and a count.

  - the head should always be an empty node

  - the count should always start at 0 and will be incremented every time a new word is inserted into our autocomplete dictionary

  the class will also have the following methods: populate, insert, suggest, and select.

  - populate allows users to create/amend the autocomplete dictionary. It will accept files.

  - insert allows users to amend the dictionary one word at a time. it will accept strings.

  - suggest allows users to input a partial word and it then suggests words based on weight.

  - select allows users to give weight to a substring and word pair
