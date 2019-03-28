require 'game'

describe 'Game' do
  let(:puzzle) { Game.new('./../lib/puzzles/sudoku1.txt') }

  describe '@board' do
    it '@board is an instance of Board' do
      expect(puzzle.instance_variable_get(:@board))
        .to be_an_instance_of Board
    end
  end

  describe '@elapsed_time' do
    it 'is an instance of Time' do
      expect(puzzle.instance_variable_get(:@elapsed_time))
        .to be_an_instance_of Time
    end
  end

  describe '#play' do
    let(:input) { StringIO.new }

    before do
      allow(puzzle).to receive(:loop).and_yield.and_yield
    end

    context 'when puzzle is solved' do
      before do
        # Suppress console output
        $stderr = File.open(File::NULL, 'w')
        $stdout = File.open(File::NULL, 'w')

        allow(puzzle.board)
          .to receive(:solved?)
          .and_return(true)
      end

      it 'breaks the loop' do
        expect(puzzle.board)
          .to receive(:solved?)
          .once

        puzzle.play
      end
    end
  end
end