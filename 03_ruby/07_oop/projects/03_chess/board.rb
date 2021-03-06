require_relative 'pieces'

class Board
  BOARD_POSITIONS = [*0..7].product([*0..7])
  attr_accessor :board

  def initialize(fill_board = true)
    populate_board(fill_board)
  end

  def populate_board(fill_board)
    @board = Array.new(8) { Array.new(8, NullPiece.instance) }

    # fill_board works with our custom #dup method
    # if set to true, only a new EMPTY board is created,
    # to be populated by already existing pieces.
    return unless fill_board

    %i[white black].each do |color|
      populate_main_pieces(color)
      populate_pawn_pieces(color)
    end
  end

  def populate_main_pieces(color)
    main_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
    ]

    i = color == :white ? 7 : 0
    main_pieces.each_with_index do |main_piece, j|
      main_piece.new(color, self, [i, j])
    end
  end

  def populate_pawn_pieces(color)
    i = color == :white ? 6 : 1
    (0..7).each { |j| Pawn.new(color, self, [i, j]) }
  end

  def add_piece(piece, pos)
    raise 'Position not empty' unless empty?(pos)

    self[pos] = piece
  end

  def move_piece(start_pos, end_pos, current_player_color)
    raise 'Starting position is empty' if empty?(start_pos)

    piece = self[start_pos]
    if piece.color != current_player_color
      raise "Pick a #{current_player_color.capitalize} piece"
    elsif !piece.moves.include?(end_pos)
      raise 'Invalid move'
    elsif !piece.valid_moves.include?(end_pos)
      raise 'Cannot move into check'
    end
    move_piece!(start_pos, end_pos)
  end

  def move_piece!(start_pos, end_pos)
    moving_piece = self[start_pos]
    raise 'Invalid chess move' unless moving_piece.moves.include?(end_pos)

    self[end_pos]    = moving_piece
    self[start_pos]  = NullPiece.instance
    moving_piece.pos = end_pos
  end

  def valid_pos?(pos)
    BOARD_POSITIONS.include?(pos)
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @board[row][col] = val
  end

  def empty?(pos)
    self[pos].empty?
  end

  def in_check?(color)
    # returns whether a player is in check
    # 1. find the position of the King on the board
    king_position = find_king(color).pos

    # 2. See if any of the opposing pieces can move to that position
    all_pieces_array.any? do |piece|
      piece.color != color && piece.moves.include?(king_position)
    end
  end

  def checkmate?(color)
    return false unless in_check?(color)

    all_pieces_array.select { |piece| piece.color == color }.all? do |own_piece|
      own_piece.valid_moves.empty?
    end
  end

  def find_king(color)
    all_pieces_array.find do |piece|
      piece.class == King && piece.color == color
    end
  end

  def all_pieces_array
    board.flatten.reject(&:empty?)
  end

  def dup
    duplicate_board = Board.new(false)

    all_pieces_array.each do |piece|
      piece.class.new(piece.color, duplicate_board, piece.pos)
    end

    duplicate_board
  end
end
