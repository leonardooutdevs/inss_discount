class Proponent
  class Discount
    def self.call(proponent)
      new(proponent).call
    end

    def initialize(proponent)
      @proponent = proponent
      @salaries = Salary.active.order(:min_amount)
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

        @discount += Calculate.call(salary, gross_salary)
      end

      @net_salary = (gross_salary - discount).round(2)
    end

    class Calculate
      def self.call(...) = new(...).call

      def initialize(salary, gross_salary)
        @salary = salary
        @gross_salary = gross_salary
      end

      def call
        max_salary = [gross_salary, max_amount].min
        taxable_amount = max_salary - min_amount

        taxable_amount * calculation_basis
      end

      private

      attr_reader :salary, :gross_salary

      delegate :min_amount, :max_amount, :calculation_basis, to: :salary
    end
  end
end
