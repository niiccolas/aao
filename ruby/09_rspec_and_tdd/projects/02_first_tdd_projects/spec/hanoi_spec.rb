require 'hanoi'

describe TowerOfHanoi do
  let(:full_ordered_stack) { [1, 2, 3, 4] }
  subject { TowerOfHanoi.new }

  describe '@towers' do
    context 'towers[:T] (top)' do
      it 'starts with a full stack of discs' do
        expect(subject.towers[:T]).to eq(full_ordered_stack)
      end

      it 'holds four discs by default' do
        expect(subject.towers[:T].size).to eq(4)
      end

      context 'when a new instance of the class is passed `num_discs` as argument ' do
        it 'holds `num_discs`' do
          num_discs = 15
          big_hanoi = TowerOfHanoi.new(num_discs)
          expect(big_hanoi.towers[:T].size).to eq(num_discs)
        end
      end

      it 'is an array' do
        expect(subject.towers[:T]).to be_an_instance_of(Array)
      end
    end

    context 'towers[:M] (Middle)' do
      it 'starts empty' do
        expect(subject.towers[:M]).to eq([])
      end

      it 'is an array' do
        expect(subject.towers[:M]).to be_an_instance_of(Array)
      end
    end

    context 'towers[:B] (Bottom)' do
      it 'starts empty' do
        expect(subject.towers[:B]).to eq([])
      end

      it 'is an array' do
        expect(subject.towers[:B]).to be_an_instance_of(Array)
      end
    end
  end

  describe '#won?' do
    context 'when the game starts' do
      it 'returns false' do
        expect(subject.won?).to be false
      end
    end

    context 'when discs have all been moved to the last tower' do
      it 'returns true' do
        subject.towers = { T: [], M: [], B: full_ordered_stack }
        expect(subject.won?).to be true
      end
    end

    context 'when the last tower is NOT a full ordered stack' do
      it 'returns false' do
        subject.towers = { T: [3, 4], M: [2], B: [1] }
        expect(subject.won?).to be false
      end
    end
  end

  describe '#move' do
    it 'only moves smaller discs on bigger ones' do
      subject.towers = { T: [3, 4], M: [2], B: [1] }
      expect { subject.move(:M, :B) }.to raise_error('Stack discs in ascending order only')
    end

    it 'moves discs one by one' do
      subject.towers = { T: [3, 4], M: [2], B: [1] }
      expect(subject.towers[:B].length).to eq(1)
      subject.move(:B, :M)
      expect(subject.towers[:B]).to be_empty
    end
  end
end
