module Proponents
  class ReportsController < ApplicationController
    after_action :start

    def index; end

    private

    def start
      Proponents::ReportsJob.set(wait: 2.seconds).perform_later
    end
  end
end
