require_relative '../lib/question_follow'

describe QuestionFollow do
  describe '::followers_for_question_id' do
    let(:following_q1) { QuestionFollow.followers_for_question_id(1) }

    it 'queries the DB only once' do
      expect(QuestionsDatabase).to receive(:execute).once.and_call_original
      following_q1
    end

    it 'returns an array of Users' do
      expect(following_q1).to be_an Array
      expect(following_q1).to all(be_a User)
    end

    it 'returns the correct followers' do
      q1_followers_fname = following_q1.map(&:fname)
      expect(q1_followers_fname).to eq(["Wendy", "Owen"])
    end
  end

  describe '::followed_questions_for_user_id' do
    let(:followed) { QuestionFollow.followed_questions_for_user_id(1) }

    it 'queries the DB only once' do
      expect(QuestionsDatabase).to receive(:execute).once.and_call_original
      followed
    end

    it 'returns an array of Question objects' do
      expect(followed).to be_an Array
      expect(followed).to all(be_a Question)
    end

    it 'returns the correct questions for given user id' do
      followed_question_ids = followed.map(&:id)
      expect(followed_question_ids).to match_array([1, 2, 3])
    end
  end

  describe '::most_followed_questions' do
    let(:m_f_q) { QuestionFollow.most_followed_questions }

    it 'queries the DB only once' do
      expect(QuestionsDatabase).to receive(:execute).once.and_call_original
      m_f_q
    end

    it 'returns an array of Question objects' do
      expect(m_f_q).to be_an Array
      expect(m_f_q).to all(be_a Question)
    end

    context 'given an argument of type integer `n`' do
      top2 = QuestionFollow.most_followed_questions(2)
      it 'returns an array of `n` most followed questions' do
        expect(top2.length).to eq(2)
        expect(top2).to be_an Array
        expect(top2).to all(be_a Question)
      end
    end
  end
end
