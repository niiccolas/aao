require 'min_max_stack'

describe 'MinMaxStack' do
  subject { MinMaxStack.new }
  let(:queue_stack) {
    subject.instance_variable_get(:@store)
  }
  let(:stack) {
    queue_stack.instance_variable_get(:@store).last
  }

  describe '#push' do
    it 'adds a value' do
      subject.push(2)
      subject.push(7)
      expect(subject.size).to eq(2)
    end

    it 'adds within a hash' do
      subject.push(2)
      expect(stack).to be_an_instance_of Hash
    end
  end

  describe '#pop' do
    it 'removes the value at the top of stack' do
      subject.push(1)
      subject.push(2)
      subject.push(7)
      subject.pop
      expect(subject.peek).to eq(2)
    end
  end

  describe '#peek' do
    it "returns stack's top" do
      expect(subject.peek).to be nil

      subject.push(42)
      expect(subject.peek).to eq(42)
      subject.push(11)
      subject.push(3)
      expect(subject.peek).to eq(3)
    end
  end

  describe '#size' do
    it "returns stack's size" do
      subject.push(11)
      subject.push(1)
      subject.push(3)
      expect(subject.size).to eq(3)
    end
  end

  describe '#empty?' do
    context 'when stack is empty' do
      it 'returns true' do
        expect(subject.empty?).to be true
      end
    end
    context 'when stack has >= 1 element' do
      it 'returns false' do
        subject.push(3)
        expect(subject.empty?).to be false
      end
    end
  end

  describe '#min' do
    it "returns stack's min value" do
      subject.push(-33)
      subject.push(2)
      subject.push(18)
      expect(subject.min).to eq(-33)
    end
  end

  describe '#max' do
    it "returns stack's max value" do
      subject.push(-33)
      subject.push(2)
      subject.push(18)
      expect(subject.max).to eq(18)
    end
  end
end
