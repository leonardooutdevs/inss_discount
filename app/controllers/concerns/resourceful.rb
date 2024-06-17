module Resourceful
  extend ActiveSupport::Concern
  class NotImplemented < StandardError; end

  included do
    delegate_missing_to :class, allow_nil: true

    before_action :set_readers
  end

  private

  attr_reader :instance

  def search_params = params[:q]
  def permitted_params = raise NotImplemented
  def resource = policy_scope(controller_name.classify.safe_constantize)
  def instance_variable_name = "@#{variable_name}"
  def variable_name = controller_name.singularize
  def locals = { variable_name => instance }.with_indifferent_access

  def scoped_resource
    scopes
      .reduce(resource) { |resource, scope| resource.public_send(scope) }
      .select(columns)
      .joins(tables)
  end

  def set_readers
    controller_klass = controller_name
    controller_singular = controller_name.singularize

    class_eval do
      attr_reader(:q, controller_klass, controller_singular)

      delegate_missing_to controller_singular.to_sym, allow_nil: true
    end
  end

  def initialize_instance(attrs = {})
    @instance = instance_variable_set(
      instance_variable_name,
      authorize(resource.new(attrs))
    )
  end

  def set_resource(...)
    args = yield if block_given?
    args ||= [instance_variable_name, resource.find(params.require(:id))]

    @instance = authorize(instance_variable_set(*args))
  end

  def render_turbo(partial, action = 'update', target = instance)
    render(
      turbo_stream: turbo_stream
      .send(
        action,
        target,
        partial:,
        locals:
      )
    )
  end

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
