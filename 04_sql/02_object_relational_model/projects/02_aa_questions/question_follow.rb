require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class QuestionFollow
  def self.find_by_id(id)
    qst_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT * FROM question_follows WHERE question_follows.id = ?
    SQL
    return nil if qst_follow.empty?

    QuestionFollow.new(qst_follow.first)
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT * FROM users
    JOIN question_follows ON question_follows.user_id = users.id
    WHERE question_follows.question_id = ?;
    SQL
    return nil if followers.empty?

    followers.map { |follower| User.new(follower) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT * FROM questions
    JOIN question_follows ON question_follows.question_id = questions.id
    WHERE question_follows.user_id = ?;
    SQL
    return nil if questions.empty?

    questions.map { |question| Question.new(question) }
  end

  # Default to top 5
  def self.most_followed_questions(n_questions = 5)
    mf_questions = QuestionsDatabase.instance.execute(<<-SQL, n_questions)
    SELECT * FROM questions
    JOIN question_follows ON question_follows.question_id = questions.id
    GROUP BY question_id
    ORDER BY COUNT(user_id) DESC
    LIMIT ?;
    SQL
    return nil if mf_questions.empty?

    mf_questions.map { |question| Question.new(question) }
  end

  attr_reader :id
  attr_accessor :question_id, :user_id

  def initialize(options)
    @id          = options['id']
    @question_id = options['question_id']
    @user_id     = options['user_id']
  end
end