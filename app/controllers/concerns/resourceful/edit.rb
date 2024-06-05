module Resourceful
  module Edit
    extend ActiveSupport::Concern

    included do
      delegate :include_nesteds, to: :class

      define_method :edit do |&block|
        set_resource
        build_nesteds if include_nesteds
        edit_content(&block)
      end

      alias_method :edit_resourceful, :edit
    end

    def edit_content(...)
      yield if block_given?

      respond_to do |format|
        format.html
        format.turbo_stream { render_turbo 'form' }
      end
    end
  end
end
