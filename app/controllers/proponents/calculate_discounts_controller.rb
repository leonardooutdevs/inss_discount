module Proponents
  class CalculateDiscountsController < ApplicationController
    def index
      return head(:unprocessable_entity) if gross_salary.blank?

      Proponents::CalculateDiscountJob.perform_later(
        gross_salary,
        current_user
      )
    end

    private

    def gross_salary = params[:gross_salary]
  end
end
