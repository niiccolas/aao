class AiPlayer
  def initialize
    @current_fragment = current_fragment
    @other_players = other_players
  end

  def words_from_fragment
    winning_words = @dictionary.select { |word| word.start_with? @fragment }

    winning_words.reject! { |word| losing_move.include? word[@fragment.length] }
  end

  def winning_moves
    return losing_move.sample if winning_words.nil?

    # winning letters, duplicates & nil removed
    winning_words.keys.map { |word| word[@fragment.length] }.uniq.compact
  end

  def losing_moves
    words_one_letter_away = @dictionary.select do |word|
      (word.start_with? @fragment) && (word.length == @fragment.length + 1)
    end

    # If added to @fragment, those letters would complete a word
    words_one_letter_away.keys.map { |word| word[-1] }
  end
end
