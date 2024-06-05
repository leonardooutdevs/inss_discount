module Resourceful
  extend ActiveSupport::Concern
  class NotImplemented < StandardError; end

  ACTIONS = %i[index show new edit create update destroy].freeze

  module ClassMethods
    attr_accessor :acts, :include_nesteds

    def resourceful(opts = {})
      self.acts = opts[:only].presence || (ACTIONS - (opts[:except].presence || []))
      self.include_nesteds = opts[:include_nesteds].to_boolean || false

      include_reads
      include_writes
    end

    def include_reads
      include Index if acts.include?(:index)
      include Show if acts.include?(:show)
      include New if acts.include?(:new)
      include Edit if acts.include?(:edit)
    end

    def include_writes
      include Create if acts.include?(:create)
      include Update if acts.include?(:update)
      include Destroy if acts.include?(:destroy)
    end
  end

  included do
    before_action :set_readers
  end

  private

  attr_reader :instance

  def search_params = params[:q]
  def permitted_params = raise NotImplemented
  def resource = controller_name.classify.safe_constantize
  def instance_variable_name = "@#{variable_name}"
  def variable_name = controller_name.singularize

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
      resource.new(attrs)
    )
  end

  def set_resource
    @instance = instance_variable_set(
      instance_variable_name,
      resource.find(params.require(:id))
    )
  end

  def render_turbo(partial)
    render(
      turbo_stream: turbo_stream
      .send(
        'update',
        instance,
        partial:,
        locals: { variable_name => instance }.with_indifferent_access
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
