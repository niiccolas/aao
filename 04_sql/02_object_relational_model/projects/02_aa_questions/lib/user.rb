require_relative 'model_base'

class User < ModelBase
  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT *
      FROM users
      WHERE users.fname = ? AND users.lname = ?
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

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    karma = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT COUNT(question_likes.question_id) / COUNT(DISTINCT questions.id) as average
    FROM questions
    LEFT OUTER JOIN question_likes ON questions.id = question_likes.question_id
    WHERE questions.author_id = ?
    SQL

    karma.first['average']
  end
end
