require 'iteration_review'

describe '#factors' do
  context "given an integer 'int'" do
    it 'returns an array of its factors' do
      expect(factors(9)).to eq([1, 3])
      expect(factors(45)).to eq([1, 3, 5, 9, 15])
    end
  end
end

describe Array do
  test_arr = Array.new(12) { rand(1..50) }

  describe '.bubble_sort!' do
    context 'given an unsorted array' do
      it 'returns a sorted array' do
        expect(test_arr.bubble_sort!).to eql(test_arr.sort)
        expect([99, -2, 10, 99.2].bubble_sort!).to eql([-2, 10, 99, 99.2])
      end

      test_arr_clone = test_arr.clone
      it 'modifies the original array' do
        expect(test_arr.bubble_sort!).not_to eql(test_arr_clone)
      end

      it 'can take an optional block' do
        expect(test_arr.bubble_sort! { |num1, num2| num1 <=> num2 } ).to eql(test_arr.sort)
      end
    end
  end

  describe '.bubble_sort' do
    context 'given an unsorted array' do
      it 'returns a sorted array' do
        expect(test_arr.bubble_sort).to eql(test_arr.sort)
      end

      it 'does NOT modify the original array' do
        expect(test_arr.bubble_sort).to eql(test_arr)
      end

      it 'can take an optional block' do
        expect(test_arr.bubble_sort { |num1, num2| num2 <=> num1 }).to eql(test_arr.sort.reverse)
      end
    end
  end
end

describe "#substrings" do
  context "given a string" do
    it 'returns all the substrings of that string' do
      expect(substrings("fat")).to eq(["f", "fa", "fat", "a", "at", "t"])
      expect(substrings("foam")).to eq(["f", "fo", "foa", "foam", "o", "oa", "oam", "a", "am", "m"])
    end
  end
end

subword_call = subwords("seassoucat..sdqfoamazeazecat", ["cat","sea","foam"])
describe "#subwords" do
  context "given a string and an array of existing words" do
    it "returns substrings that are actual words" do
      expect(subword_call).to eq(["sea", "cat", "foam"])
    end
    it "rejects words that are not in the dictionary" do
      expect(subword_call).not_to include("ecat", "seassou")
    end
    it 'does NOT match tangled words' do
      expect(subwords("sesafuoam", ["sea", "foam"])).to be_empty
    end
  end
end