module Proponents
  class CalculateDiscountJob < ApplicationJob
    include MoneyHelper

    queue_as :proponent

    def perform(gross_salary, current_user)
      @current_user = current_user

      @discount, @net_salary = Proponent::Discount.call(Proponent.new(gross_salary:))

      update_discount
      update_net_salary
    end

    private

    attr_reader :discount, :net_salary, :current_user

    def update_discount
      Turbo::StreamsChannel.broadcast_update_to(
        "proponents_form_for_#{current_user.id}",
        target: "net_salary_for_#{current_user.id}",
        content: m(net_salary)
      )
    end

    def update_net_salary
      Turbo::StreamsChannel.broadcast_update_to(
        "proponents_form_for_#{current_user.id}",
        target: "discount_for_#{current_user.id}",
        content: m(discount)
      )
    end
  end
end
