module Resourceful
  module Create
    extend ActiveSupport::Concern

    included do
      define_method :create do |&block|
        initialize_instance(permitted_params)
        create_content(&block)
      end

      alias_method :create_resourceful, :create
    end

    protected

    def create_content(...)
      if instance.save
        yield if block_given?

        return render_turbo(variable_name, 'update', resource.new) if turbo

        respond_to do |format|
          format.html { redirect_to url_for([controller_name.to_sym]), notice: t('.success') }
        end
      else
        render_turbo('form')
      end
    end
  end
end
