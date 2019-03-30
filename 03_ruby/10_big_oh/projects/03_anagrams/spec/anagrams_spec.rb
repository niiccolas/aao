require 'anagrams'

describe 'Given two strings' do
  anagrams = [
    ['eva', 'ave'],
    ['ales', 'sale'],
    ['elvis', 'lives'],
    ['trance', 'nectar']
  ]

  not_anagrams = [
    ['eva', 'ava'],
    ['blue', 'suede'],
    ['horse', 'harsh'],
    ['pizzaz', 'fizzle']
  ]

  describe '#first_anagram?' do
    context 'when second string is an anagram of the first' do
      it 'returns true' do
        anagrams.each do |anagram|
          expect(first_anagram?(*anagram)).to be true
        end
      end
    end

    context 'else' do
      it 'returns false' do
        not_anagrams.each do |not_anagram|
          expect(first_anagram?(*not_anagram)).to be false
        end
      end
    end
  end

  describe '#second_anagram?' do
    context 'when second string is an anagram of the first' do
      it 'returns true' do
        anagrams.each do |anagram|
          expect(second_anagram?(*anagram)).to be true
        end
      end
    end

    context 'else' do
      it 'returns false' do
        not_anagrams.each do |not_anagram|
          expect(first_anagram?(*not_anagram)).to be false
        end
      end
    end
  end

  describe '#third_anagram?' do
    context 'when second string is an anagram of the first' do
      it 'returns true' do
        anagrams.each do |anagram|
          expect(third_anagram?(*anagram)).to be true
        end
      end
    end

    context 'else' do
      it 'returns false' do
        not_anagrams.each do |not_anagram|
          expect(third_anagram?(*not_anagram)).to be false
        end
      end
    end
  end

  describe '#fourth_anagram?' do
    context 'when second string is an anagram of the first' do
      it 'returns true' do
        anagrams.each do |anagram|
          expect(fourth_anagram?(*anagram)).to be true
        end
      end
    end

    context 'else' do
      it 'returns false' do
        not_anagrams.each do |not_anagram|
          expect(fourth_anagram?(*not_anagram)).to be false
        end
      end
    end
  end
end