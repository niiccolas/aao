require 'my_stack'

describe 'MyStack' do
  subject { MyStack.new }
  let(:stack) { subject.instance_variable_get(:@store) }

  describe '#push' do
    it 'adds an element' do
      subject.push(11)
      expect(stack.size).to eq(1)
      subject.push(22)
      subject.push(33)
      expect(stack.size).to eq(3)
    end

    it 'returns nil' do
      expect(subject.push(11)).to eq(nil)
    end
  end

  describe '#pop' do
    it 'removes the last element in' do
      subject.push(22)
      subject.push(33)
      subject.pop
      expect(stack.size).to eq(1)
    end

    it 'returns last element in' do
      subject.push(22)
      subject.push(33)
      expect(subject.pop).to eq(33)
    end
  end

  describe '#empty?' do
    context 'when stack is empty' do
      it 'returns true' do
        expect(subject.empty?).to eq(true)
      end
    end
    context 'when stack has >= 1 element' do
      it 'returns false' do
        subject.push(7)
        expect(subject.empty?).to eq(false)
      end
    end
  end

  describe '#size' do
    it "returns stack's size" do
      subject.push(7)
      subject.push(7)
      subject.push(7)
      expect(subject.size).to eq(3)
    end
  end

  describe '#peek' do
    it "returns stack's top element" do
      subject.push(5)
      subject.push(6)
      subject.push(7)
      expect(subject.peek).to eq(7)
    end

    it 'does not remove the peeked item' do
      subject.push(3)
      subject.push(9)
      subject.push(12)
      subject.peek
      expect(stack.first).to eq(3)
    end
  end
end