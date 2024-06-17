module Resourceful
  module Scope
    extend ActiveSupport::Concern

    included do
      before_action :set_scope_reader, if: lambda { scope.present? }
      before_action :set_scope, if: lambda { scope.present? }
    end

    private

    attr_reader :scope_instance

    def scope_resource = scope.to_s.classify.safe_constantize
    def scope_id = params["#{scope}_id".to_sym].to_i
    def scope_variable_name = "@#{scope}"

    def set_scope_reader
      return if scope.blank?

      scope_name = scope
      class_eval do
        attr_reader(scope_name)
      end
    end

    def set_scope
      return if scope.blank?

      element = scope_resource.find(scope_id)
      scope_resource_instance = decorate ? element.decorate : element

      @scope_instance =
        instance_variable_set(
          scope_variable_name,
          scope_resource_instance
        )
    end
  end
end
