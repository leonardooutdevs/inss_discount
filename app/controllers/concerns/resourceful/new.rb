module Resourceful
  module New
    extend ActiveSupport::Concern

    included do
      define_method :new do |&block|
        initialize_instance
        build_nesteds if include_nesteds
        new_content(&block)
      end

      alias_method :new_resourceful, :new
    end

    protected

    def new_content(...)
      yield if block_given?

      return render_turbo('form', 'prepend', controller_name) if turbo

      respond_to do |format|
        format.html
      end
    end
  end
end
