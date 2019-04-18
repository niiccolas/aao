require_relative 'questions_database'
require_relative 'question'
require_relative 'user'

class QuestionLike
  def self.find_by_id(id)
    qst_like = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT * FROM question_likes WHERE question_likes.id = ?
    SQL
    return nil if qst_like.empty?

    QuestionLike.new(qst_like.first)
  end

  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT * FROM users
    JOIN question_likes ON question_likes.user_id = users.id
    WHERE question_likes.question_id = ?;
    SQL
    return nil if likers.empty?

    likers.map { |liker| User.new(liker) }
  end

  def self.num_likes_for_question_id(question_id)
    num_likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT COUNT(*) AS count FROM question_likes
    WHERE question_likes.question_id = ?;
    SQL

    num_likes.first['count']
  end

  def self.liked_questions_for_user_id(user_id)
    liked_questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT * from questions
    JOIN question_likes ON question_likes.question_id = questions.id
    WHERE question_likes.user_id = ?
    SQL
    return nil if liked_questions.empty?

    liked_questions.map { |liked_question| Question.new(liked_question) }
  end

  def self.most_liked_questions(n = 1)
    most_liked = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT *, COUNT(question_id) AS likes
    FROM questions
    JOIN question_likes ON question_likes.question_id = questions.id
    GROUP BY title
    ORDER BY likes DESC
    LIMIT ?;
    SQL
    return nil if most_liked.empty?

    most_liked.map { |liked_question| Question.new(liked_question) }
  end

  attr_reader :id
  attr_accessor :user_id, :question_id

  def initialize(options)
    @id          = options['id']
    @user_id     = options['user_id']
    @question_id = options['question_id']
  end
end
