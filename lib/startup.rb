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
    # continue here
  end
end