# Chess (Part One)

- ⏱ 6 hours

Write a [chess game](http://en.wikipedia.org/wiki/Chess) using object-oriented programming.

**Please read all through the various phases before proceeding.**

Review the [Chess UML Diagram](http://assets.aaonline.io/fullstack/ruby/assets/Chess_Diagram.png) to get an overview of what you'll be creating. The diagram is beneficial for getting an idea of how different aspects of the project fit together; however, you should **code your project by following the instructions closely and using the diagram only as a reference**. It'll be helpful for clearing up any confusion about how classes inherit from or relate to one another.

You must split your program into multiple files. Use [`require_relative`](http://www.ruby-doc.org/core-2.1.2/Kernel.html#method-i-require_relative) to load files. Make separate files for each class. Give files `snake_case` titles.

Don't forget to keep using Git. Look back at [Minesweeper's instructions](https://open.appacademy.io/learn/full-stack-online-ruby/minesweeper) and read the Git portions again if you need a reminder. Accessing this on GitHub? Use [this link](https://github.com/appacademy/curriculum/blob/master/ruby/projects/minesweeper/). Committing and branching are important habits for any kind of software developer.

## Learning Goals

- Know when and why private methods are used
- Be able to read UML and understand the benefits of UML
- Be familiar with how to use the Singleton module
- Know how to use modules
- Know how class inheritance works

## Phase I: `Board`

Your `Board` class should hold a 2-dimensional array (an array of arrays). Each position in the board either holds a moving `Piece` or a `NullPiece`(`NullPiece` will inherit from `Piece`).

You'll want to create an empty `Piece` class as a placeholder for now. Write code for `#initialize` so we can setup the board with instances of `Piece` in locations where a `Queen`/`Rook`/`Knight`/ etc. will start and `nil` where the `NullPiece` will start.

The `Board` class should have a `#move_piece(start_pos, end_pos)` method. This should update the 2D grid and also the moved piece's position. You'll want to raise an exception if:

1. there is no piece at `start_pos` or
2. the piece cannot move to `end_pos`.

**Time to test!** Open up pry and `load 'board.rb'`. Create an instance of `Board` and check out different positions with `board[pos]`. Do you get back `Piece` instances where you expect to? Test out `Board#move_piece(start_pos, end_pos)`, does it raise an error when there is no piece at the start? Does it successfully update the `Board`?

Once you get some of your pieces moving around the board, **call over your TA for a code-review**.

## Phase II: `Display`

Write a `Display` class to handle your rendering logic. Your `Display` class should access the board. Require the [`colorize`](https://github.com/fazibear/colorize) gem so you can render in color.

Download this `cursor.rb` [file](http://assets.aaonline.io/fullstack/ruby/projects/chess/cursor.rb). An instance of `Cursor` initializes with a `cursor_pos` and an instance of `Board`. The cursor manages user input, according to which it updates its `@cursor_pos`. The display will render the square at `@cursor_pos` in a different color. Within `display.rb` require `cursor.rb` and set the instance variable `@cursor` to `Cursor.new([0,0], board)`.

In `cursor.rb` we've provided a `KEYMAP` that translates keypresses into actions and movements. The `MOVES` hash maps possible movement differentials. You can use the `#get_input` method as is. `#read_char` handles console input. Skim over `#read_char` to gain a general understanding of how the method works. It's all right if the `STDIN` methods are unfamiliar. Don't fret the details.

Fill in the `#handle_key(key)` method. Use a [case statement](http://ruby-doc.org/docs/keywords/1.9/Object.html#method-i-case) that switches on the value of `key`. Depending on the `key`, `#handle_key(key)` will a) return the `@cursor_pos` (in case of `:return` or `:space`), b) call `#update_pos` with the appropriate movement difference from `MOVES` and return `nil` (in case of `:left`, `:right`, `:up`, and `:down`), or c) exit from the terminal process (in case of `:ctrl_c`). Later we will use our `Player` and `Game` classes to handle the movement of pieces.

**NB:** To exit a terminal process, use the `Process.exit` method. Pass it the status code `0` as an argument. You can read more about `exit` [here](http://ruby-doc.org/core-2.2.0/Process.html#method-c-exit).

Fill in the `#update_pos(diff)` method. It should use the `diff` to reassign `@cursor_pos` to a new position. You may wish to write a `Board#valid_pos?`method to ensure you update `@cursor_pos` only when the new position is on the board.

Render the square at the `@cursor_pos` display in a different color. Test that you can move your cursor around the board by creating and calling a method that loops through `Display#render` and `Cursor#get_input` (much as `Player#make_move` will function later!).

A nice but optional addition to your cursor class is a boolean instance variable `selected` that will allow you to display the cursor in a different color when it has selected a piece. To implement this you will need to `#toggle_selected` everytime `:return` or `:space` is hit.

**NB:** **If you're stuck on making a cursor for more than 30 minutes, please call for help from a TA**. Fancy cursors are cool, but the purpose of today is to become more familiar with Object-oriented Programming.

**Time to test!** This time you should run `ruby display.rb`. Does your board render as you would expect? Make sure that as you move your cursor the display updates accordingly. Test the cursor's behavior when you try and move it off the board (the edge cases if you will). Does it do what you expect?

**Code Review Time:** Before moving on to piece logic, get a code review from a TA!

## Head to Part 2!

Once you are finished with phases I & II head over to Part Two. Accessing this on GitHub? Use [this link](https://github.com/appacademy/curriculum/blob/master/ruby/projects/chess/part_two.md).