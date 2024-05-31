class Proponent
  class Discount
    def self.call(proponent)
      new(proponent).call
    end

    def initialize(proponent)
      @proponent = proponent
      @salaries = Salary.actives.order(:min_amount)
      @discount = 0
      @net_salary = 0
    end

    def call
      return if gross_salary.blank?

      calculate_discount

      @proponent.discount = discount.round(2)
      @proponent.net_salary = (gross_salary - discount).round(2)

      [proponent.discount, proponent.net_salary]
    end

    private

    attr_reader :proponent, :salaries, :discount, :net_salary

    delegate :gross_salary, to: :proponent, allow_nil: true

    def calculate_discount
      salaries.each do |salary|
        break if gross_salary <= salary.min_amount

        max_salary = [gross_salary, salary.max_amount].min
        taxable_amount = max_salary - salary.min_amount

        @discount += taxable_amount * salary.calculation_basis
      end

      @net_salary = (gross_salary - discount).round(2)
    end
  end
end
