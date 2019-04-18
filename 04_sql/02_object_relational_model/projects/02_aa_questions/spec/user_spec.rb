require_relative '../lib/user'
require_relative '../lib/questions_database'

describe User do
  let(:wendy) { User.find_by_name('Wendy', 'Glover') }
  let(:owen)  { User.find_by_name('Owen', 'Greenholt') }
  let(:unknown_user) { User.find_by_name('Louie', 'Nottindeebee') }

  describe '::find_by_name' do
    context "given a user's fname & lname" do
      context 'if user is in db' do
        it 'returns a User object' do
          expect(wendy).to be_a(User)
        end

        it 'returns the user matching given fname & lname' do
          expect(wendy.fname).to eq('Wendy')
          expect(wendy.lname).to eq('Glover')
        end
      end

      context 'if user is not in db' do
        it 'returns nil' do
          expect(unknown_user).to eq(nil)
        end
      end
    end
  end

  describe '#authored_questions' do
    let(:stub_question_class) { class_double('Question').as_stubbed_const }

    it 'calls Question::find_by_author_id' do
      expect(stub_question_class)
      .to receive(:find_by_author_id)
      .with(wendy.id)

      wendy.authored_questions
    end
  end

  describe '#authored_replies' do
    let(:stub_reply_class) { class_double('Reply').as_stubbed_const }

    it 'calls Reply::find_by_user_id' do
      expect(stub_reply_class)
      .to receive(:find_by_user_id)
      .with(wendy.id)

      wendy.authored_replies
    end
  end

  describe '#followed_questions' do
    let(:stub_question_follow_class) { class_double('QuestionFollow').as_stubbed_const }

    it 'calls QuestionFollow::followed_questions_for_user_id' do
      expect(stub_question_follow_class)
      .to receive(:followed_questions_for_user_id)
      .with(wendy.id)

      wendy.followed_questions
    end
  end

  describe '#liked_questions' do
    let(:stub_question_like_class) { class_double('QuestionLike').as_stubbed_const }

    it 'calls QuestionLike::liked_questions_for_user_id' do
      expect(stub_question_like_class)
      .to receive(:liked_questions_for_user_id)
      .with(wendy.id)

      wendy.liked_questions
    end
  end

  describe '#average_karma' do
    it 'returns an integer' do
      expect(wendy.average_karma).to be_an Integer
    end

    it 'returns average karma for current user' do
      expect(wendy.average_karma).to eq 1 # Wendy's karma is 1
      expect(owen.average_karma).to eq 2 # Owen's' karma is 2
    end

    it 'queries the DB only once' do
      expect(QuestionsDatabase)
      .to receive(:get_first_value)
      .exactly(1).times

      User.find_by_id(3).average_karma
    end
  end
end