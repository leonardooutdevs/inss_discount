module Resourceful
  module Index
    extend ActiveSupport::Concern

    included do
      class_attribute :resource_actions, default: {}
      delegate :resource_actions, to: :class

      define_method :index do
        @q = resource.ransack(search_params)

        instance_variable_set(
          instance_variable_name.pluralize,
          q.result(distinct: true).page(params[:page]).per(params[:per])
        )
      end
    end
  end
end
