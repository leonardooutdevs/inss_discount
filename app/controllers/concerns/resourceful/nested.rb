module Resourceful
  module Nested
    extend ActiveSupport::Concern

    private

    def build_nesteds(...)
      nesteds = yield if block_given?
      nesteds ||= resource.nested_attributes_options.keys

      nesteds.each do |association|
        next if instance.send(association).present?

        build_nested_associations(association)
      end
    end

    def build_nested_associations(nested, instance_obj = nil)
      instance_obj ||= instance

      association = instance_obj.send(nested)

      return instance_obj.send("build_#{nested}") unless association

      association_built = association.build

      association_built.nested_attributes_options.each_key do |built_nested|
        build_nested_associations(built_nested, association_built)
      end
    end
  end
end
