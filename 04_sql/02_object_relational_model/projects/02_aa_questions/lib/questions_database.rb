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

  def self.get_first_row(*args)
    instance.get_first_row(*args)
  end

  def self.get_first_value(*args)
    instance.get_first_value(*args)
  end

  def self.execute(*args)
    instance.execute(*args)
  end
end