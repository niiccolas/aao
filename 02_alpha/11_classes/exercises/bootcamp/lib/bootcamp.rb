class Bootcamp
  def initialize(name, slogan, student_capacity)
    @name             = name
    @slogan           = slogan
    @student_capacity = student_capacity
    @teachers         = []
    @students         = []
    @grades           = Hash.new { |hash, key| hash[key] = [] }
  end

  # Getters & Setters, all at once
  # https://ruby-doc.org/core-2.5.1/Module.html#method-i-attr_accessor
  attr_accessor :name
  attr_accessor :slogan
  attr_accessor :student_capacity
  attr_accessor :teachers
  attr_accessor :students
  attr_accessor :grades

  # Instance Methods
  def hire(teacher)
    @teachers << teacher
  end

  def enroll(student)
    has_capacity = @students.count < @student_capacity
    return @students << student && true if has_capacity

    false
  end

  def enrolled?(student)
    @students.include?(student)
  end

  def student_to_teacher_ratio
    @students.count / @teachers.count
  end

  def add_grade(student, grade)
    return @grades[student] << grade && true if enrolled?(student)

    false
  end

  def num_grades(student)
    @grades[student].count
  end

  def average_grade(student)
    return nil unless enrolled?(student) && num_grades(student) > 0

    @grades[student].reduce(:+) / num_grades(student)
  end
end
