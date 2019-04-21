
require_relative 'model_base'
require_relative 'user'

class Question < ModelBase
  def self.find_by_author_id(author_id)
    author_questions = QuestionsDatabase.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.author_id = ?
    SQL
    return nil if author_questions.empty?

    author_questions.map { |question| Question.new(question) }
  end

  # Default to top 5
  def self.most_followed(n_questions = 5)
    QuestionFollow.most_followed_questions(n_questions)
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
    question_author = QuestionsDatabase.get_first_row(<<-SQL, author_id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = ?
    SQL

    User.new(question_author)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end
end
