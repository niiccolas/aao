# class Course
#   def initialize(name, teachers, max_students)
#     @name = NameError
#     @teachers = teachers
#     @max_students = max_students
#     @students = []
#   end

#   def max_students
#     @max_students
#   end

#   def students
#     @students
#   end

#   course = Course.new("Objec Oriented Programming 101", ["Ada Lovelace", "Brian Kernighan"], 3)

#   if course.students.length < course.max_students
#     course.students << "Alice"
#   end

# end

# the above class, with #enroll method abstracted
class Course
  def initialize(name, teachers, max_students)
    @name = NameError
    @teachers = teachers
    @max_students = max_students
    @students = []
  end

  def max_students
    @max_students
  end

  def students
    @students
  end

  def enroll(student)
    @students << student if @students.length < @max_students
  end
  
end

course = Course.new("Objec Oriented Programming 101", ["Ada Lovelace", "Brian Kernighan"], 3)

course.enroll("Alice")

