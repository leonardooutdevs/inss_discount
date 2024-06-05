module Resourceful
  module New
    extend ActiveSupport::Concern

    included do
      delegate :include_nesteds, to: :class

      define_method :new do
        initialize_instance
        build_nesteds if include_nesteds
      end
    end
  end
end
