module Resourceful
  module Edit
    extend ActiveSupport::Concern

    included do
      define_method :edit do |&block|
        set_resource
        build_nesteds if include_nesteds
        edit_content(&block)
      end

      alias_method :edit_resourceful, :edit
    end

    protected

    def edit_content(...)
      yield if block_given?

      return render_turbo('form') if turbo

      respond_to do |format|
        format.html
      end
    end
  end
end
