module Resourceful
  module Show
    extend ActiveSupport::Concern

    included do
      define_method :show do
        set_resource
        render_turbo(variable_name)
      end
    end
  end
end
