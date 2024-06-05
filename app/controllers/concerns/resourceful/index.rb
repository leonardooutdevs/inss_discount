module Resourceful
  module Index
    extend ActiveSupport::Concern

    included do
      class_attribute :resource_actions, default: {}
      delegate :resource_actions, to: :class

      define_method :index do |&block|
        index_content(&block)
      end

      alias_method :index_resourceful, :index

      def index_content(...)
        yield if block_given?

        set_resources

        respond_to do |format|
          format.html
          format.json { render json: send(controller_name) }
        end
      end

      def set_resources
        @q ||= resource.ransack(search_params)

        instance_variable_set(
          instance_variable_name.pluralize,
          q.result(distinct: true).page(params[:page]).per(params[:per])
        )
      end
    end
  end
end
