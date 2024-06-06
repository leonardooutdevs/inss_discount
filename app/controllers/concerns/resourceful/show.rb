module Resourceful
  module Show
    extend ActiveSupport::Concern

    included do
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
      element = scoped_resource.find(params.require(:id))
      set_resource do
        [
          instance_variable_name,
          decorate ? element.decorate : element
        ]
      end
    end
  end
end
