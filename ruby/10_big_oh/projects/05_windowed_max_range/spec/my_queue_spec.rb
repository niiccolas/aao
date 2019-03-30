require 'my_queue'

describe 'MyQueue' do
  subject { MyQueue.new }
  let(:queue) { subject.instance_variable_get(:@store) }

  describe '#enqueue' do
    it 'adds to the back of the queue' do
      subject.enqueue(22)
      expect(queue.first).to eq(22)
    end

    it 'returns nil' do
      expect(subject.enqueue(42)).to eq(nil)
    end
  end

  describe '#dequeue' do
    it 'removes from the front of the queue' do
      subject.enqueue(11)
      subject.enqueue(22)
      subject.enqueue(33)
      subject.dequeue
      expect(queue).to eq([33, 22])
    end

    it 'returns the dequeued element' do
      subject.enqueue(11)
      subject.enqueue(22)
      subject.enqueue(33)
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

  describe '#peek' do
    it "returns queue's next element" do
      subject.enqueue(22)
      subject.enqueue(11)
      subject.enqueue(44)
      expect(subject.peek).to eq(22)
    end

    it 'does not remove the peeked item' do
      subject.enqueue(11)
      subject.enqueue(44)
      expect(subject.peek).to eq(11)
      expect(queue[-1]).to eq(11)
    end
  end
end
