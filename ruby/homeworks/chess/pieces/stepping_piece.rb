module SteppingPiece
  def moves
    puts
    puts 'from SteppingPiece'
    self.move_diffs
  end

  def move_diffs
    raise NotImplementedError
  end
end