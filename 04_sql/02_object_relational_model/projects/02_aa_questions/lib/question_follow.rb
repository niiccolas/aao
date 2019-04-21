require_relative 'questions_database'
require_relative 'question'
require_relative 'user'

class QuestionFollow < ModelBase
  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      JOIN
        question_follows
      ON
        question_follows.user_id = users.id
      WHERE
        question_follows.question_id = ?;
    SQL

    followers.empty? ? nil : followers.map { |follower| User.new(follower) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      JOIN
        question_follows
      ON
        question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = ?;
    SQL

    questions.empty? ? nil : questions.map { |question| Question.new(question) }
  end

  # Default to top 5
  def self.most_followed_questions(n_questions = 5)
    mf_questions = QuestionsDatabase.execute(<<-SQL, n_questions)
    SELECT
      questions.*
    FROM
      questions
    JOIN
      question_follows
    ON
      question_follows.question_id = questions.id
    GROUP BY
      question_follows.question_id
    ORDER BY
      COUNT(question_follows.user_id) DESC
    LIMIT
      ?;
    SQL

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
