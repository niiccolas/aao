require_relative '../lib/question_like'

describe QuestionLike do
  describe '::find_by_id' do
    it 'queries the DB only once' do
      expect(QuestionsDatabase).to receive(:get_first_row).once.and_call_original
      QuestionLike.find_by_id(1)
    end

    it 'returns a QuestionLike object' do
      expect(QuestionLike.find_by_id(1)).to be_a QuestionLike
    end

    it 'returns the correct QuestionLike' do
      this_question = QuestionLike.find_by_id(1)
      expect(this_question.id).to be(1)
    end
  end

  describe '::likers_for_question_id' do
    it 'queries the DB only once' do
      expect(QuestionsDatabase).to receive(:execute).once.and_call_original
      QuestionLike.likers_for_question_id(1)
    end

    it 'return an array of User objects' do
      expect(QuestionLike.likers_for_question_id(4)).to be_an Array
      expect(QuestionLike.likers_for_question_id(4)).to all(be_a User)
    end

    context 'when the question has no likes' do
      # question_id 1 has no likes
      it 'returns nil' do
        expect(QuestionLike.likers_for_question_id(1)).to be nil
      end
    end
  end

  describe '::num_likes_for_question_id' do
    it 'queries the DB only once' do
      expect(QuestionsDatabase).to receive(:get_first_value).once.and_call_original
      QuestionLike.num_likes_for_question_id(4)
    end

    it 'returns the number of likes for that question' do
      expect(QuestionLike.num_likes_for_question_id(4)).to eq(2)
      expect(QuestionLike.num_likes_for_question_id(4)).not_to eq(22)
    end

    it 'returns an Integer' do
      expect(QuestionLike.num_likes_for_question_id(4)).to be_an Integer
    end
  end

  describe '::liked_questions_for_user_id' do
    let(:liked_qst) { QuestionLike.liked_questions_for_user_id(1) }

    it 'queries the DB only once' do
      expect(QuestionsDatabase).to receive(:execute).once.and_call_original
      liked_qst
    end

    it 'returns an array of Questions objects' do
      expect(liked_qst).to be_an Array
      expect(liked_qst).to all(be_a Question)
    end

    context 'when user questions have no likes' do
      it 'returns nil' do
        expect(QuestionLike.liked_questions_for_user_id(3)).to be nil
      end
    end
  end

  describe '::most_liked_questions' do
    it 'queries the DB only once' do
      expect(QuestionsDatabase).to receive(:execute).once.and_call_original
      QuestionLike.most_liked_questions
    end

    it 'returns an array of Questions' do
      expect(QuestionLike.most_liked_questions).to be_an Array
      expect(QuestionLike.most_liked_questions).to all(be_a Question)
    end

    it 'returns the most liked question by default' do
      expect(QuestionLike.most_liked_questions.length).to be 1
    end

    context 'given a parameter of type integer `n`' do
      it 'returns an array of `n` most liked questions' do
        top2 = QuestionLike.most_liked_questions(2)
        expect(top2.length).to be 2
        expect(top2).to be_an Array
        expect(top2).to all(be_a Question)
      end
    end
  end
end
