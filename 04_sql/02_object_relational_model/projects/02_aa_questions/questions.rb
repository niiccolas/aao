require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton # enforces a unique connection to the DB

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash  = true
  end
end

class Question
  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT * FROM questions WHERE questions.id = ?
    SQL
    return nil if question.empty?

    Question.new(question.first)
  end

  def self.find_by_author_id(author_id)
    author_questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT * FROM questions WHERE questions.author_id = ?
    SQL
    return nil if author_questions.empty?

    author_questions.map { |question| Question.new(question) }
  end

  attr_reader :id
  attr_accessor :title, :body, :author_id

  def initialize(options)
    @id        = options['id']
    @title     = options['title']
    @body      = options['body']
    @author_id = options['author_id']
  end

  def author
    question_author = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT * FROM users WHERE users.id = ?
    SQL

    User.new(question_author.first)
  end

  def replies
    Reply.find_by_question_id(@id)
  end
end

class User
  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT * FROM users WHERE users.id = ?
    SQL
    return nil if user.empty?

    User.new(user.first)
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT * FROM users WHERE users.fname = ? AND users.lname = ?
    SQL
    return nil if user.empty?

    User.new(user.first)
  end

  attr_reader :id
  attr_accessor :fname, :lname

  def initialize(options)
    @id    = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end
end

class Reply
  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT * FROM replies WHERE replies.id = ?
    SQL
    return nil if reply.empty?

    Reply.new(reply.first)
  end

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

class QuestionFollow
  def self.find_by_id(id)
    qst_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT * FROM question_follows WHERE question_follows.id = ?
    SQL
    return nil if qst_follow.empty?

    QuestionFollow.new(qst_follow.first)
  end

  attr_reader :id
  attr_accessor :question_id, :user_id

  def initialize(options)
    @id          = options['id']
    @question_id = options['question_id']
    @user_id     = options['user_id']
  end
end

class QuestionLike
  def self.find_by_id(id)
    qst_like = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT * FROM question_likes WHERE question_likes.id = ?
    SQL
    return nil if qst_like.empty?

    QuestionLike.new(qst_like.first)
  end

  attr_reader :id
  attr_accessor :user_id, :question_id

  def initialize(options)
    @id          = options['id']
    @user_id     = options['user_id']
    @question_id = options['question_id']
  end
end
