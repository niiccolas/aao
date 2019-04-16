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
  end

  def self.all
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT *
      FROM #{table};
    SQL

    self.parse_all(data)
  end

  def self.parse_all(data)
    data.map { |element| new(element) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT * FROM #{table} WHERE #{table}.id = ?
    SQL

    data.nil? ? nil : new(data.first)
  end
end