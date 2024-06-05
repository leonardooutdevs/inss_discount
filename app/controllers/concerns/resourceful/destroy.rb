module Resourceful
  module Destroy
    extend ActiveSupport::Concern

    included do
      define_method :destroy do |*args, &block|
        set_resource
        destroy_content(*args, &block)
      end
    end

    protected

    def destroy_content(...)
      path = url_for([controller_name.to_sym])

      if instance.destroy!
        return yield if block_given?

        redirect_to path, notice: t('.success')
      else
        redirect_to path, notice: t('.failure')
      end
    end
  end
end
