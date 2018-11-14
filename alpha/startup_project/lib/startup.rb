require_relative './employee.rb'

# :nodoc:
class Startup
  attr_accessor :name, :funding, :salaries, :employees

  def initialize(name, funding, salaries)
    @name      = name
    @funding   = funding
    @salaries  = salaries
    @employees = []
  end

  def valid_title?(title)
    @salaries.key?(title)
  end

  def >(other)
    @funding > other.funding
  end

  def hire(name, title)
    raise '--- INVALID TITLE ---' unless valid_title?(title)

    @employees << Employee.new(name, title)
  end

  def size
    @employees.count
  end

  def pay_employee(employee)
    salary = @salaries[employee.title]
    raise '--- NOT ENOUGH FUNDING ---' if salary > @funding

    employee.pay(salary)
    @funding -= salary
  end

  def payday
    @employees.each { |employee| pay_employee(employee) }
  end

  def average_salary
    titles       = @employees.map(&:title)
    all_salaries = titles.map { |title| @salaries[title] }
    all_salaries.reduce(:+) / @employees.count
  end

  def close
    @employees = []
    @funding   = 0
  end

  def acquire(new_startup)
    @funding += new_startup.funding

    # update without overwriting existing salary values
    @salaries.update(new_startup.salaries) { |_key, oldval, _newval| oldval }
    @employees.concat(new_startup.employees)
    new_startup.close
  end
end
