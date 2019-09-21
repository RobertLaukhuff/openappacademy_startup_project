require_relative "employee"

class Startup

  attr_reader :name, :funding, :salaries, :employees

  def initialize(name, funding, salaries)
    @name = name
    @funding = funding
    @salaries = salaries
    @employees = []
  end

  def valid_title?(title)
    @salaries.keys.include?(title)
  end

  def >(other_startup)
    self.funding > other_startup.funding
  end

  def hire(name, title)
    if !valid_title?(title)
      raise "#{title} is not a valid title"
    else
      @employees << Employee.new(name, title)
    end
  end

  def size
    @employees.length
  end

  def pay_employee(employee)
    pay_amount = @salaries[employee.title]
    if @funding > pay_amount
      employee.pay(pay_amount)
      @funding -= pay_amount
    else
      raise "Not enough funds available"
    end
  end

  def payday
    @employees.each {|employee| self.pay_employee(employee)}
  end

  def average_salary
    pay_total = 0
    @employees.each do |employee|
      pay_total += @salaries[employee.title]
    end
    pay_total / (@employees.length * 1.0)
  end

  def close
    @employees = []
    @funding = 0
  end

  def acquire(startup)
    @funding += startup.funding
    startup.salaries.each do |title, salary|
      if !@salaries.keys.include?(title)
        @salaries[title] = salary
      end
    end
    @employees.push(*startup.employees)
    startup.close
  end
end