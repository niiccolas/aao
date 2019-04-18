require_relative '../lib/question'
require_relative '../lib/reply'
require_relative '../lib/question_follow'
require_relative '../lib/question_like'

describe Question do
  let(:wendys_questions) { Question.find_by_author_id(1) }

  describe '::find_by_author_id' do
    it 'returns an array of Question objects' do
      expect(wendys_questions).to be_an Array
      expect(wendys_questions).to all(be_a(Question))
    end

    it 'returns the relevant question(s)' do
      wendys_questions.each do |question|
        expect(question.author.fname).to eq('Wendy')
      end
    end

    context 'when author_id is not in db' do
      it 'returns nil' do
        expect(Question.find_by_author_id(999)).to be nil
      end
    end
  end

  describe '::most_followed' do
    it 'calls QuestionFollow::most_followed_questions' do
      expect(QuestionFollow)
      .to receive(:most_followed_questions).once

      Question.most_followed
    end

    it 'returns an array of Question objects' do
      mf_questions = Question.most_followed
      expect(mf_questions).to be_an Array
      expect(mf_questions).to all(be_a(Question))
    end

    # question_id 4 => 3 followers, 1 => 2, 2 => 1
    it 'returns the 5 most followed questions' do
      mf_5_questions = Question.most_followed.map(&:id)
      expect(mf_5_questions).to eq([4, 1, 2])
    end

    context 'when given an integer n as argument' do
      it 'returns n most followed questions' do
        expect(Question.most_followed(3).length).to eq(3)
        expect(Question.most_followed(1).length).to eq(1)
      end
    end
  end

  describe '#author' do
    ginas_question = Question.find_by_id(1)

    it 'returns the author of a question' do
      expect(ginas_question.author.fname).to eq('Gina')
      expect(ginas_question.author.lname).to eq('Ratke')
    end

    it 'returns a User object' do
      expect(ginas_question.author).to be_a User
    end
  end

  describe '#replies' do
    owens_question = Question.find_by_id(4)
    replies        = owens_question.replies

    it 'calls Reply::find_by_question_id' do
      expect(Reply)
      .to receive(:find_by_question_id)
      .once.with(owens_question.id)

      owens_question.replies
    end

    it 'returns an array of Reply objects' do
      expect(replies).to be_an Array
      expect(replies).to all(be_a Reply)
    end

    it 'returns replies to the current question' do
      replies_curr = replies.map(&:question_id).uniq
      expect(*replies_curr).to eq(4)
    end
  end

  describe '#followers' do
    followed_by_wendy = Question.find_by_id(2)

    it 'calls QuestionFollow::followers_for_question_id' do
      expect(QuestionFollow)
      .to receive(:followers_for_question_id)
      .once.with(followed_by_wendy.id)

      followed_by_wendy.followers
    end

    it 'returns an array of User objects' do
      expect(followed_by_wendy.followers).to be_an Array
      expect(followed_by_wendy.followers).to all(be_a(User))
    end
  end

  describe '#likers' do
    question = Question.find_by_id(4)

    it 'calls QuestionLike::likers_for_question_id' do
      expect(QuestionLike)
      .to receive(:likers_for_question_id)
      .once.with(question.id)

      question.likers
    end

    it 'returns an array of User objects' do
      expect(question.likers).to all(be_a User)
    end
  end

  describe '#num_likes' do
    question = Question.find_by_id(4)

    it 'calls QuestionLike::num_likes_for_question_id' do
      expect(QuestionLike)
      .to receive(:num_likes_for_question_id)
      .once.with(question.id)

      question.num_likes
    end

    it 'returns an integer' do
      expect(question.num_likes).to be_an Integer
    end
  end
end
