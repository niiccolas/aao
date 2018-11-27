class AiPlayer
  attr_reader :name, :type

  def initialize
    @name = %w[Casper Jacob Slimey Abe Duppy].sample + ' (AI)'
    @type = 'ai'
  end

  def guess(dic, frag)
    return ('a'..'z').to_a.sample if frag.empty?

    return winning_moves(dic, frag).sample unless winning_moves(dic, frag).empty?

    losing_moves(dic, frag).sample
  end

  def winning_moves(dictionary, fragment)
    winning_words = dictionary.select { |word| word.start_with? fragment }

    if fragment.length > 1
      winning_words.reject! do |word|
        losing_moves(dictionary, fragment).include? word[fragment.length]
      end
    end

    # winning letters, duplicates & nil removed
    winning_words.keys.map { |word| word[fragment.length] }.uniq.compact
  end

  def losing_moves(dic, frag)
    words_one_letter_away = dic.select do |word|
      (word.start_with? frag) && (word.length == frag.length + 1)
    end

    # If added to @fragment, those letters would complete a word
    words_one_letter_away.keys.map { |word| word[-1] }
  end

  def alert_invalid_guess(letter)
    puts
    puts "#{letter} is invalid input! Pick a letter of the alphabet,\n"
    print "while forming an existing word. Try again: "
    puts

    puts "cancel if this goes in infinite loop"
    gets.chomp
  end
end
