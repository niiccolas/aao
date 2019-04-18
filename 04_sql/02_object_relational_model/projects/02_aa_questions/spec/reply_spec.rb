require_relative '../lib/reply'
require_relative '../lib/user'
require_relative '../lib/question'

describe Reply do
  describe '::find_by_user_id' do
    reply = Reply.find_by_user_id(1)
    it 'returns an array of Reply object(s)' do
      expect(reply).to be_an Array
      expect(reply).to all(be_a Reply)
    end

    context 'if user_id is not in DB' do
      it 'returns nil' do
        expect(Reply.find_by_user_id(999)).to eq(nil)
      end
    end
  end

  describe '::find_by_question_id' do
    reply = Reply.find_by_question_id(4)
    it 'returns an array of Reply object(s)' do
      # Seed DB has replies for question_id 4 only
      expect(reply).to be_an Array
      expect(reply).to all(be_a Reply)
    end

    context 'if question_id is not in DB' do
      it 'returns nil' do
        expect(Reply.find_by_question_id(999)).to eq(nil)
      end
    end
  end

  let(:reply) { Reply.find_by_id(1) }

  describe '#author' do
    it 'returns the correct author' do
      expect(reply.author.fname).to eq('Wendy')
      expect(reply.author.lname).to eq('Glover')
    end

    it 'returns a User object' do
      expect(reply.author).to be_a User
    end

    it 'calls User::find_by_id' do
      expect(User).to receive(:find_by_id).once
      Reply.find_by_id(2).author
    end
  end

  describe '#question' do
    it 'returns the question replied to' do
      expect(reply.question.title).to eq("Owen: Roommates")
      expect(reply.question.id).to eq(4)
      expect(reply.question.body).to eq("Hey guys! My name is Owen and I’m looking to move to SF from Arizona if I get accepted into App Academy. I'm looking for roommates who love accuracy and use tabs")
    end

    it 'returns a Question object' do
      expect(reply.question).to be_a Question
    end

    it 'calls Question::find_by_id' do
      expect(Question).to receive(:find_by_id).once
      Reply.find_by_id(3).question
    end
  end

  # replies to Owen's question in the seed DB
  first_reply  = Reply.find_by_id(1)
  second_reply = Reply.find_by_id(2)
  third_reply  = Reply.find_by_id(3)
  last_reply   = Reply.find_by_id(4)

  describe '#parent_reply' do
    context 'when querying the very first reply' do
      it 'returns nil' do
        expect(first_reply.parent_reply).to be nil
      end
    end

    it 'returns the parent reply of the current one' do
      expect(second_reply.parent_reply.id).to eq(first_reply.id)
    end

    it 'returns a Reply object' do
      expect(second_reply.parent_reply).to be_a Reply
    end
  end

  describe '#child_replies' do
    it 'returns an array of Reply object(s)' do
      expect(first_reply.child_replies).to be_an Array
      expect(first_reply.child_replies).to all(be_a Reply)
    end

    it 'returns all the replies to the current one' do
      expect(first_reply.child_replies[0].id).to eq(second_reply.id)
      expect(first_reply.child_replies[1].id).to eq(third_reply.id)
    end

    context 'when a reply is the last child' do
      it 'returns nil' do
        expect(last_reply.child_replies).to be nil
      end
    end
  end
end
