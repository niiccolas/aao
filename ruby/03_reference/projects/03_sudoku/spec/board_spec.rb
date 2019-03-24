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

    it 'fills array with Tile instances' do
      all_tiles_instances = file_parser.flatten.all? { |el| el.is_a? Tile }

      expect(all_tiles_instances).to be true
    end
  end

  context 'given a tile x,y position in the grid' do
    describe '#[]=' do
      it "updates the tile's value" do
        subject[0, 0] = 9
        expect(subject[0, 0].value).to eq(9)

        subject[0, 0] = 7
        expect(subject[0, 0].value).to eq(7)
      end
    end

    describe '#[]' do
      it 'returns the tile' do
        expect(almost_solved[0, 8]).to be_an_instance_of Tile
        expect(almost_solved[0, 8].value).to eq(7)
        expect(sudoku_solved[0, 0].value).to eq(4)
      end
    end
  end

  describe '#rows_solved?' do
    context 'when all rows are solved' do
      it 'returns true' do
        expect(sudoku_solved.rows_solved?).to be true
      end
    end

    it 'returns false' do
      expect(sudoku.rows_solved?).to be false
      expect(almost_solved.rows_solved?).to be false
    end
  end

  describe '#columns_solved?' do
    context 'when all columns are solved' do
      it 'returns true' do
        expect(sudoku_solved.columns_solved?).to be true
      end
    end

    it 'returns false' do
      expect(sudoku.columns_solved?).to be false
      expect(almost_solved.columns_solved?).to be false
    end
  end

  describe '#squares_solved?' do
    context 'when all 3x3 squares are solved' do
      it 'returns true' do
        expect(sudoku_solved.squares_solved?).to be true
      end
    end

    it 'returns false' do
      expect(sudoku.squares_solved?).to be false
      expect(almost_solved.squares_solved?).to be false
    end
  end
end
