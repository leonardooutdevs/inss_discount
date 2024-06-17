module Resourceful
  module Update
    extend ActiveSupport::Concern

    included do
      define_method :update do |&block|
        set_resource
        update_content(&block)
      end

      alias_method :update_resourceful, :update
    end

    protected

    def update_content(...)
      if instance.update(permitted_params)
        yield if block_given?

        return render_turbo(variable_name) if turbo

        respond_to do |format|
          format.html { redirect_to url_for([:edit, instance]), notice: t('.success') }
        end
      else
        render_turbo('form')
      end
    end
  end
end
