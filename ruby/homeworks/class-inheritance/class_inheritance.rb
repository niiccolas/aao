class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name   = name
    @title  = title
    @salary = salary
    @boss   = boss
  end

  def bonus(multiplier)
    salary * multiplier
  end
end

class Manager < Employee
  attr_accessor :subordinates
  def initialize(name, title, salary, boss)
    super(name, title, salary, boss)
    @subordinates = []
  end

  def bonus(multiplier)
    subordinates.map(&:salary).sum * multiplier
  end

  def add_subordinates(*employees)
    employees.each { |employee| subordinates << employee }
  end
end

ned    = Manager.new('Ned', 'Founder', 1_000_000, nil)
darren = Manager.new('Darren', 'TA Manager', 78_000, ned)
shawna = Employee.new('Shawna', 'TA', 12_000, darren)
david  = Employee.new('David', 'TA', 10_000, darren)

darren.add_subordinates(shawna, david)
ned.add_subordinates(darren, shawna, david)

p david.bonus(3)  # 30_000
p shawna.bonus(3) # 36_000
p darren.bonus(4) # 88_000
p ned.bonus(5)    # 500_000
