require 'anagrams'

describe '#first_anagram?' do
  context 'when second string is anagram of the first' do
    it 'returns true' do
      expect(first_anagram?('eva', 'ave')).to be true
      expect(first_anagram?('ales', 'sale')).to be true
      expect(first_anagram?('elvis', 'lives')).to be true
      expect(first_anagram?('trance', 'nectar')).to be true
    end
  end

  context 'when second string is NOT an anagram of the first' do
    it 'returns false' do
      expect(first_anagram?('eva',  'ava')).to be false
      expect(first_anagram?('blue', 'suede')).to be false
      expect(first_anagram?('horse', 'harsh')).to be false
      expect(first_anagram?('pizzaz', 'fizzle')).to be false
    end
  end
end
