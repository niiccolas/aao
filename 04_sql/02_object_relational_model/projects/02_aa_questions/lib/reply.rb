require_relative 'model_base'

class Reply < ModelBase
  def self.find_by_user_id(user_id)
    user_replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT * FROM replies WHERE replies.user_id = ?
    SQL
    return nil if user_replies.empty?

    user_replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    qst_replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT * FROM replies WHERE replies.question_id = ?
    SQL
    return nil if qst_replies.empty?

    qst_replies.map { |reply| Reply.new(reply) }
  end

  attr_reader :id
  attr_accessor :question_id, :parent_reply_id, :user_id, :body

  def initialize(options)
    @id              = options['id']
    @question_id     = options['question_id']
    @parent_reply_id = options['parent_reply_id']
    @user_id         = options['user_id']
    @body            = options['body']
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    return nil if @parent_reply_id.nil? # first reply has no parent!

    Reply.find_by_id(@parent_reply_id)
  end

  def child_replies
    child_replies = QuestionsDatabase.instance.execute(<<-SQL, @question_id, @id)
    SELECT * FROM replies WHERE replies.question_id = ? AND replies.parent_reply_id = ?
    SQL
    return nil if child_replies.empty?

    child_replies.map { |child_reply| Reply.new(child_reply) }
  end
end
