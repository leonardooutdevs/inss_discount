module Resourceful
  module Show
    extend ActiveSupport::Concern

    included do
      define_method :show do |&block|
        set_resource
        show_content(&block)
      end

      alias_method :show_resourceful, :show
    end

    def show_content(...)
      yield if block_given?

      respond_to do |format|
        format.html
        format.turbo_stream { render_turbo(variable_name) }
      end
    end
  end
end
