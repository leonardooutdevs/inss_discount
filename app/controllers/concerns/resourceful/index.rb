module Resourceful
  module Index
    extend ActiveSupport::Concern

    included do
      define_method :index do |&block|
        index_content(&block)
      end

      alias_method :index_resourceful, :index
    end

    protected

    def index_content(...)
      set_content(...)

      respond_to do |format|
        format.html
        format.json { render json: send(controller_name) }
      end
    end

    def set_content(...)
      yield if block_given?

      @q ||= scoped_resource.ransack(search_params)

      set_index_resource
    end

    def set_index_resource
      instance_variable_set(
        instance_variable_name.pluralize,
        q.result(distinct: true).page(params[:page]).per(params[:per])
      )
    end
  end
end
