require_relative 'pieces/piece'
require_relative 'pieces/queen'
require_relative 'pieces/king'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/pawn'
require_relative 'pieces/nullpiece'

k = King.new(:white, 'brd', [0,0])
p k.symbol
p k.move_diffs

