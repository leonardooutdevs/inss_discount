module Resourceful
  module Update
    extend ActiveSupport::Concern

    included do
      define_method :update do
        set_resource
        update_content
      end
    end

    protected

    def update_content
      if instance.update(permitted_params)
        return yield if block_given?

        redirect_to url_for([:edit, instance]), notice: t('.success')
      else
        render_turbo('form')
      end
    end
  end
end
