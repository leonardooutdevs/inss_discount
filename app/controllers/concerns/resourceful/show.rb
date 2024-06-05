module Resourceful
  module Show
    extend ActiveSupport::Concern

    included do
      delegate :resource_actions, :columns, :tables, to: :class

      define_method :show do |&block|
        set_show_resource
        show_content(&block)
      end

      alias_method :show_resourceful, :show
    end

    protected

    def show_content(...)
      yield if block_given?

      respond_to do |format|
        format.html
        format.turbo_stream { render_turbo(variable_name) }
      end
    end

    def set_show_resource
      set_resource do
        [
          instance_variable_name,
          resource.select(columns).joins(tables).find(params.require(:id))
        ]
      end
    end
  end
end
