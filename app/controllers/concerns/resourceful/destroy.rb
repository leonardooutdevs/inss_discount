module Resourceful
  module Destroy
    extend ActiveSupport::Concern

    included do
      define_method :destroy do |&block|
        set_resource
        destroy_content(&block)
      end

      alias_method :destroy_resourceful, :destroy
    end

    protected

    def destroy_content(...)
      block_given? ? yield : instance.try(:inactive!) || instance.destroy!

      return render(turbo_stream: turbo_stream.remove(instance)) if turbo

      redirect_to url_for([controller_name.to_sym]), notice: t('.success')
    end
  end
end
