require 'game'
require 'board'

describe 'Game' do
  let(:puzzle) { Game.new(Board.new('./../lib/puzzles/sudoku1.txt')) }
  let(:solved) { Game.new(Board.new('./../lib/puzzles/sudoku1_solved.txt')) }
  let(:almost) { Game.new(Board.new('./../lib/puzzles/sudoku1_almost.txt')) }

  it 'has a @board' do
    expect(puzzle.instance_variables).to include(:@board)
  end

  it '@board is an instance of Board' do
    expect(puzzle.instance_variable_get(:@board)).to be_an_instance_of Board
  end

  describe '#play' do
    context 'until the puzzle is solved' do
      before do
        allow(puzzle.board).to receive(:solved?).and_return(false, false, false, true)
      end

      it 'keeps looping' do
        expect(puzzle.board).to receive(:solved?).exactly(4).times
        expect(puzzle.board).to receive(:render).exactly(4).times
        puzzle.play
      end

      it 'renders the board' do
        expect(puzzle.board).to receive(:render).exactly(4).times
        puzzle.play
      end
    end

    context 'when puzzle is solved' do
      before do
        # Suppress console output
        $stderr = File.open(File::NULL, "w")
        $stdout = File.open(File::NULL, "w")

        allow(puzzle.board).to receive(:solved?).and_return(true)
      end

      it 'breaks the loop' do
        expect(puzzle.board).to receive(:solved?).once

        puzzle.play
      end
    end
  end

  describe '#prompt' do
    before { allow(puzzle).to receive(:prompt).and_return(pos: [2, 2], val: 9) }

    it 'returns a hash' do
      expect(puzzle.prompt).to be_an_instance_of Hash
    end

    it 'returns a key :pos, array of size 2' do
      expect(puzzle.prompt.keys).to include :pos
      expect(puzzle.prompt[:pos]).to be_an_instance_of Array
      expect(puzzle.prompt[:pos].length).to eq(2)
    end

    it 'returns a key :val, single Integer between 1-9' do
      expect(puzzle.prompt).to eq(pos: [2, 2], val: 9)
      expect(puzzle.prompt[:val]).to be_an_instance_of Integer
    end
  end
end