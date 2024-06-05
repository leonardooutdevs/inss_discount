module Resourceful
  module Edit
    extend ActiveSupport::Concern

    included do
      define_method :edit do
        set_resource
        build_nesteds if include_nesteds
      end
    end
  end
end
