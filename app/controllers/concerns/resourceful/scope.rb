module Resourceful
  module Scope
    extend ActiveSupport::Concern

    included do
      before_action :set_scope
    end

    private

    attr_reader :scope_instance

    def scope_resource = scope.to_s.classify.safe_constantize
    def scope_id = params["#{scope}_id".to_sym].to_i

    def set_scope
      return if scope.blank?

      scope_name = scope
      class_eval do
        attr_reader(scope_name)
      end

      @scope_instance = instance_variable_set("@#{scope}", scope_resource.find(scope_id))
    end
  end
end
