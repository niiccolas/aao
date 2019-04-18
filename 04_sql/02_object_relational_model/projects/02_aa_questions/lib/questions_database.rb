require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton # enforces a unique connection to the DB

  def initialize
    Dir.chdir(File.dirname(__FILE__))
    super('questions.db')
    self.type_translation = true
    self.results_as_hash  = true
  end
end