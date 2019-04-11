require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    # Dir.chdir(File.dirname(__FILE__))
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_title(title)
    play = PlayDBConnection.instance.execute(<<-SQL)
      SELECT *
      FROM plays
      WHERE title LIKE "%#{title}%"
    SQL
    return nil if play.empty?

    Play.new(*play)
  end

  def self.find_by_playwright(name)
    plays = PlayDBConnection.instance.execute(<<-SQL)
      SELECT *
      FROM plays
      JOIN playwrights ON playwrights.id = plays.playwright_id
      WHERE playwrights.name LIKE "%#{name}%"
      ORDER BY plays.year
    SQL
    return "#{name} not found in DB" if plays.empty?

    plays.map { |play| Play.new(play) }
  end

  def initialize(options)
    @id            = options['id']
    @title         = options['title']
    @year          = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end

class Playwright
  attr_accessor :name, :birth_year
  attr_reader   :id

  def self.all
    data = PlayDBConnection.instance.execute('SELECT * FROM playwrights')
    data.map { |datum| Playwright.new(datum) }
  end

  def self.find_by_name(name)
    playwright = PlayDBConnection.instance.execute(<<-SQL)
      SELECT *
      FROM playwrights
      WHERE name LIKE "%#{name}%"
    SQL
    return nil if playwright.empty?

    Playwright.new(*playwright)
  end

  def initialize(options)
    @id         = options['id']
    @name       = options['name']
    @birth_year = options['birth_year']
  end

  def self.in_db?(pw_name)
    search = PlayDBConnection.instance.execute(<<-SQL)
      SELECT COUNT(*) as result
      FROM playwrights
      WHERE name = "#{pw_name}"
    SQL
    search.first['result'] >= 1
  end

  def in_db?
    search = PlayDBConnection.instance.execute(<<-SQL, self.name)
      SELECT COUNT(*) as result
      FROM playwrights
      WHERE name = ?
    SQL
    search.first['result'] >= 1
  end

  def create
    return puts "#{self.name} already in database" if in_db?
    # raise "#{self} already in database" if @id

    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
      INSERT INTO
        playwrights (name, birth_year)
      VALUES
        (?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    # raise "#{self} not in db" unless in_db?
    raise "#{self} not in db" unless self.id

    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year, self.id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays
    PlayDBConnection.instance.execute(<<-SQL)
      SELECT DISTINCT plays.title, plays.year, playwrights.name
      FROM plays
      JOIN
        playwrights ON playwrights.id = plays.playwright_id
      WHERE
        playwrights.name LIKE "%#{self.name}%"
    SQL
  end
end
