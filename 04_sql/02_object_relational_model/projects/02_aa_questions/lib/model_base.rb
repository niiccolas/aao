require 'active_support/inflector'
require_relative 'questions_database'

class ModelBase
  def self.table
    self.to_s.tableize
  end

  def save
    @id ? update : create # is Object already in DB ?
  end

  def attributes
    instance_variables.map do |i_var|
      [i_var.to_s[1..-1], instance_variable_get(i_var)]
    end.to_h
  end

  def create
    raise 'Already in DB' if @id

    instance_attr  = attributes
    instance_attr.delete('id')
    sql_col_names  = instance_attr.keys.join(', ')
    sql_values     = instance_attr.values
    question_marks = (['?'] * instance_attr.count).join(', ')

    QuestionsDatabase.instance.execute(<<-SQL, *sql_values)
      INSERT INTO
        #{self.class.table}(#{sql_col_names})
      VALUES
        (#{question_marks})
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise 'Not in DB: cannot update' unless @id

    instance_attr = attributes
    instance_attr.delete('id')
    new_values = instance_attr.values
    sql_set    = instance_attr.keys.map { |attr| attr + ' = ?' }.join(', ')

    QuestionsDatabase.instance.execute(<<-SQL, *new_values)
      UPDATE
        #{self.class.table}
      SET
        #{sql_set}
      WHERE
        #{self.class.table}.id = #{@id};
    SQL
  end

  def self.where(options)
    if options.is_a? Hash
      sql_where = options.keys.map { |key| key.to_s + ' = ?' }.join(', ')
      values    = options.values
    else
      sql_where = options
      values    = nil
    end

    data = QuestionsDatabase.instance.execute(<<-SQL, *values)
      SELECT *
      FROM   #{table}
      WHERE  #{sql_where};
    SQL

    parse_all(data)
  end

  def self.find_by(options)
    sql_where = options.keys.map { |key| key.to_s + ' = ?' }.join('AND ')

    data = QuestionsDatabase.instance.execute(<<-SQL, *options.values)
      SELECT *
      FROM   #{table}
      WHERE  #{sql_where};
    SQL

    parse_all(data)
  end

  def self.all
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT *
      FROM #{table};
    SQL

    parse_all(data)
  end

  def self.parse_all(data)
    data.map { |element| new(element) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM   #{table}
      WHERE  #{table}.id = ?
    SQL

    data.nil? ? nil : self.new(data.first)
  end
end