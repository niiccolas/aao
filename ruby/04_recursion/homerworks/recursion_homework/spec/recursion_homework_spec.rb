require 'recursion_homework'

describe "#sum_to(n)" do
  context "Given an positive integer n" do
    it "should return the sum from 1 to n" do
      expect(sum_to(5)).to eq(15)
      expect(sum_to(1)).to eq(1)
      expect(sum_to(9)).to eq(45)
    end
  end
  context "Given a negative integer n" do
    it "should return nil" do
      expect(sum_to(-8)).to eq(nil)
    end
  end
end

describe "#add_numbers(arr)" do
  context "given an array of integers" do
    it "should return the sum of the integers" do
      expect(add_numbers([1,2,3,4])).to eq(10)
      expect(add_numbers([3])).to eq(3)
      expect(add_numbers([-80,34,7])).to eq(-39)
    end
  end

  context "given an empty array" do
    it "should return nil" do
    expect(add_numbers([])).to eq(nil)
    end
  end
end

describe "#gamma_fnc(n)" do
  context "given an integer n > 0" do
    it "should return its gamma function" do
    expect(gamma_fnc(1)).to eq(1)
    expect(gamma_fnc(4)).to eq(6)
    expect(gamma_fnc(8)).to eq(5040)
    end
  end
  context "given 0" do
    it "should return nil" do
      expect(gamma_fnc(0)).to eq(nil)
    end
  end
end

describe "#ice_cream_shop(flavors, favorite)" do
  context "given an array of strings representing flavors, and a string representing a favorite flavor" do
    it "should return true if the favorite flavor is present in the flavors array" do
    expect(ice_cream_shop(['vanilla', 'strawberry'], 'blue moon')).to eq(false)
    expect(ice_cream_shop(['pistachio', 'green tea','chocolate', 'mint chip'], 'green tea')).to eq(true)
    expect(ice_cream_shop(['cookies n cream', 'blue moon','superman', 'honey lavender', 'sea salt caramel'],'pistachio')).to eq(false)
    expect(ice_cream_shop(['moose tracks'], 'moose tracks')).to eq(true)
    expect(ice_cream_shop([], 'honey lavender')).to eq(false)
    end
  end
end

describe "#reverse(string)" do
  context "given a string" do
    it "should reverse the string" do
    expect(reverse("house")).to eq("esuoh")
    expect(reverse("dog")).to eq("god")
    expect(reverse("atom")).to eq("mota")
    expect(reverse("q")).to eq("q")
    expect(reverse("id")).to eq("di")
    expect(reverse("")).to eq("")
    end
  end
end
