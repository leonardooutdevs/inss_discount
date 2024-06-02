module Addresses
  class SearchController < ApplicationController
    def index
      return head(:unprocessable_entity) if zip_code.blank?

      render(json: Addresses::Fetch.call(zip_code))
    end

    private

    def zip_code = params[:zip_code]
  end
end
