require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)

    winning_node = node.children.shuffle.find { |child| child.winning_node?(mark) }
    return winning_node.prev_move_pos if winning_node

    no_lose_node = node.children.shuffle.find { |child| !child.losing_node?(mark) }
    return no_lose_node.prev_move_pos if no_lose_node

    raise "I'm sorry Human, I'm afraid I cannot lose"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  print "Enter your name, human: "
  name = gets.chomp
  hp = HumanPlayer.new(name)
  cp = SuperComputerPlayer.new

  puts
  TicTacToe.new(hp, cp).run
end
