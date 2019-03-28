require 'board'

describe 'Board' do
  puzzle = './../lib/puzzles/sudoku1.txt'
  solved = './../lib/puzzles/sudoku1_solved.txt'
  almost = './../lib/puzzles/sudoku1_almost.txt'

  subject(:sudoku) { Board.new(puzzle) }
  let(:file_parser)   { Board.from_file(puzzle)}
  let(:sudoku_solved) { Board.new(solved) }
  let(:almost_solved) { Board.new(almost) }

  describe '::from_file' do
    it 'returns a 2D array' do
      expect(file_parser).to be_an_instance_of(Array)
      expect(file_parser.all? { |el| el.is_a? Array }).to be true
    end

    it 'returns an array of Tile instances' do
      all_tiles_instances = file_parser.flatten.all? { |el| el.is_a? Tile }

      expect(all_tiles_instances).to be true
    end
  end

  context 'given a tile x,y position in the grid' do
    describe '#[]=' do
      it "updates the tile's value" do
        sudoku[0, 0] = 9
        expect(sudoku[0, 0].value).to eq(9)

        sudoku[0, 0] = 7
        expect(sudoku[0, 0].value).to eq(7)
      end
    end

    describe '#[]' do
      it 'returns the tile object' do
        expect(almost_solved[0, 8]).to be_an_instance_of Tile
        expect(almost_solved[0, 8].value).to eq(7)
        expect(sudoku_solved[0, 0].value).to eq(4)
      end
    end
  end

  describe '#solved?' do
    context 'when all rows, columns and squares are solved' do
      it 'returns true' do
        expect(sudoku_solved.solved?).to be true
      end
    end

    context 'when one row or column or square is not solved' do
      it 'returns false' do
        expect(almost_solved.solved?).to be false
        expect(sudoku.solved?).to be false
      end
    end
  end

  describe '#valid_pos?' do
    let!(:within_board) { [*0..8].product([*0..8]) }
    let!(:outside_board) { [*-1..9].product([*-1..9]) - within_board }

    context 'given a position that is on the board' do
      it 'returns true' do
        within_board.all? do |pos|
          expect(sudoku.valid_pos?(pos)).to be true
        end
      end
    end

    context 'given a position outside the board' do
      it 'returns false' do
        outside_board.all? do |pos|
          expect(sudoku.valid_pos?(pos)).to be false
        end
      end
    end
  end
end
