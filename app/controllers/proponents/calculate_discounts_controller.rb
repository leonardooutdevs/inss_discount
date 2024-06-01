module Proponents
  class CalculateDiscountsController < ApplicationController
    def index
      return head(:unprocessable_entity) if params[:gross_salary].blank?

      Proponents::CalculateDiscountJob.perform_later(
        params[:gross_salary],
        current_user
      )
    end
  end
end
