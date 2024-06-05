module Resourceful
  module Create
    extend ActiveSupport::Concern

    included do
      define_method :create do |*args, &block|
        initialize_instance(permitted_params)
        create_content(*args, &block)
      end
    end

    protected

    def create_content(...)
      if instance.save
        return yield if block_given?

        redirect_to url_for([controller_name.to_sym]), notice: t('.success')
      else
        render_turbo('form')
      end
    end
  end
end
