require 'recursion_exercises'

describe "#range" do
  context "given an end integer <= than the start integer" do
    it "should return an empty array" do
    expect(range(9,3)).to eq([])
    end
  end
  context "given a start integer and an end integer" do
    it "should return an array of the range between start & end" do
      expect(range(1,10)).to eq((1...10).to_a)
    end
    it "should exclude the end num from the result" do
      expect(range(1,10).last).not_to eq(10)
    end
  end
end

describe "#sum_array_recursive and _iterative" do
  context "given an array of length > 1" do
    it "should return the sum of that array" do
      dummy_arr = Array.new(5) { rand(50) }
      expect(sum_array_recursive(dummy_arr)).to eq(dummy_arr.sum)
      expect(sum_array_iterative(dummy_arr)).to eq(dummy_arr.sum)
    end
  end
  context "given an array of length 1" do
    it "should return the first element in the array" do
      expect(sum_array_recursive([83])).to eq(83)
      expect(sum_array_iterative([83])).to eq(83)
    end
  end
end

describe "#exponent_v1 & #exponent_v2" do
  context "given an integer b as base and an integer n as exponent" do
    it "should calculate the exponent n of base b" do
      expect(exponent_v1(3, 4)).to eq(3**4)
      expect(exponent_v2(3, 4)).to eq(3**4)
      expect(exponent_v1(24, 6)).to eq(24**6)
      expect(exponent_v2(2, 14)).to eq(2**14)
    end
  end
  context "given an exponent of 0" do
    it "should return 1" do
      expect(exponent_v1(rand(1000),0)).to eq(1)
      expect(exponent_v2(rand(500),0)).to eq(1)
    end
  end
end

describe "Array#deep_dup" do
  context "passed to an array object" do
    it "should return a deep copy of it" do
      playlist = ["Around The World", ["Human After All", "Technologic"]]
      burn_playlist_to_cd = playlist.deep_dup
      burn_playlist_to_cd[1] << "Robot Rock"
      expect(playlist.include?("Robot Rock")).not_to eq(true)
    end
  end
end

describe "#fibonacci" do
  context "given an integer n > 1" do
    it "should return the first n Fibonaccy numbers" do
      expect(fibonacci(6)).to eq([0, 1, 1, 2, 3, 5])
    end
  end
  context "given 0" do
    it "should return []" do
      expect(fibonacci(0)).to eq([])
    end
  end
  context "given 1" do
    it "should return [0]" do
      expect(fibonacci(1)).to eq([0])
    end
  end
end

describe "#fibr" do
  context "given an integer n > 1" do
    it "should return the first n Fibonaccy numbers" do
      expect(fibr(6).length).to eq(6)
    end
  end
  context "given 0" do
    it "should return []" do
      expect(fibr(0)).to eq([])
    end
  end
  context "given 1" do
    it "should return [0]" do
      expect(fibr(1)).to eq([0])
    end
  end
end

describe "#bsearch(arr, target)" do
  context "given an array arr and an integer target" do
    it "should find the index of target in arr" do
      expect(bsearch([1, 2, 3, 4, 5], 5)).to eq(4)
      expect(bsearch([1, 2, 3], 1)).to eq(0)
      expect(bsearch([2, 3, 4, 5], 3)).to eq(1)
      expect(bsearch([2, 4, 6, 8, 10], 6)).to eq(2)
      #

      expect(bsearch([1, 3, 4, 5, 9], 5)).to eq(3)
      expect(bsearch([1, 2, 3, 4, 5, 6], 6)).to eq(5)
    end
  end
  context "given an empty array" do
    it "should return nil" do
      expect(bsearch([], 5)).to eq(nil)
    end
  end
  context "when target is not in the array" do
    it "should return nil" do
      expect(bsearch([1, 2, 3, 4, 5, 6], 0)).to eq(nil)
      expect(bsearch([1, 2, 3, 4, 5, 7], 6)).to eq(nil)
    end
  end
end

describe "#merge_sort" do
  context "given an array" do
    given_array = [38, 27, 43, 3, 9, 82, 1, 10, 0]
    it "returns a sorted array" do
      expect(merge_sort(given_array)).to eq(given_array.sort)
    end
  end
  context "given an empty" do
    it "should return nil" do
    expect(merge_sort([])).to eq(nil)
    end
  end
end

describe "#subsets" do
  context "given an array" do
    it "should return all subsets of given array" do
    expect(subsets([1,2])).to eq([[],[1], [2], [1,2]])
    expect(subsets([1])).to eq([[], [1]])
    expect(subsets([1, 2])).to eq([[], [1], [2], [1, 2]])
    expect(subsets([1, 2, 3])).to eq([[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]])
    end
  end
  context "given an empty array" do
    it "should return an empty array within an empty array" do
    expect(subsets([])).to eq([[]])
    end
  end
end
