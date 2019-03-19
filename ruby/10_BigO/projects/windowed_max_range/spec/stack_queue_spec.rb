require 'stack_queue'

describe 'StackQueue' do
  subject { StackQueue.new }
  let(:in_stack) { subject.instance_variable_get(:@in_stack) }
  let(:out_stack) { subject.instance_variable_get(:@out_stack) }

  describe '#enqueue' do
    it 'adds to the back of in_stack' do
      subject.enqueue(12)
      subject.enqueue(22)
      expect(in_stack.peek).to eq(22)
    end

    it 'returns nil' do
      expect(subject.enqueue(42)).to eq(nil)
    end
  end

  describe '#dequeue' do
    context 'when out_stack is empty' do
      it 'empties in_stack in out_stack' do
        subject.enqueue(11)
        subject.enqueue(22)
        subject.enqueue(33)
        subject.dequeue

        expect(in_stack.empty?).to be true
        expect(out_stack.size).to eq(2)
        expect(out_stack.peek).to eq(22)
      end
    end

    it 'returns the dequeued element' do
      subject.enqueue(11)
      subject.enqueue(22)
      expect(subject.dequeue).to eq(11)
    end
  end

  describe '#empty?' do
    context 'when queue is empty' do
      it 'returns true' do
        expect(subject.empty?).to eq(true)
      end
    end

    context 'when queue has >= 1 element' do
      it 'returns false' do
        subject.enqueue(2)
        expect(subject.empty?).to eq(false)
      end
    end
  end

  describe '#size' do
    it "returns queue's size" do
      expect(subject.size).to eq(0)

      subject.enqueue(22)
      subject.enqueue(33)
      expect(subject.size).to eq(2)
    end
  end
end
