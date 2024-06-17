module Seeds
  class AccessPermission
    class << self
      def import
        return if ::AccessPermission.exists?

        create_accesses_permissions
        create_accesses_levels
        associate_accesses
      end

      private

      def create_accesses_permissions
        Rails.application.eager_load!
        ApplicationRecord.descendants.each do |model|
          ::AccessPermission.create(model:, name: model)
        end
      end

      def create_accesses_levels
        %w[default read write admin superadmin].each do |kind|
          ::AccessLevel.create(kind:, name: kind)
        end
      end

      def associate_accesses
        ::AccessPermission.all.each do |access_permission|
          ::AccessLevel.all.each do |access_level|
            access_permission.access_levels << access_level
            puts "=== Associated permission to level #{access_permission.model} -> #{access_level.kind}"
          end
        end
      end
    end
  end
end
