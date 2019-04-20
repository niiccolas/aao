require_relative 'model_base'

class User < ModelBase
  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.get_first_row(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        users.fname = ? AND users.lname = ?
    SQL

    user.nil? ? nil : User.new(user)
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
    QuestionsDatabase.get_first_value(<<-SQL, self.id)
      SELECT
        COUNT(question_likes.question_id) / COUNT(DISTINCT questions.id)
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        questions.author_id = ?
    SQL
  end
end
