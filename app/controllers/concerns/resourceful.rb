module Resourceful
  extend ActiveSupport::Concern
  class NotImplemented < StandardError; end

  included do
    before_action :set_reader
    before_action :set_resource, only: %i[show edit update]
    before_action :initialize_instance, only: %i[new create]
    before_action :build_nesteds, only: %i[new edit]
  end

  def index
    @q = resource.ransack(search_params)
    instance_variable_set(
      instance_variable_name.pluralize,
      q.result(distinct: true).page(params[:page]).per(params[:per])
    )
  end

  def show
    render_turbo(variable_name)
  end

  def new; end
  def edit; end

  def create(...)
    initialize_instance(permitted_params)

    if instance.save
      return yield if block_given?

      redirect_to url_for([controller_name.to_sym]), notice: t('.success')
    else
      render_turbo('form')
    end
  end

  def update
    if instance.update(permitted_params)
      return yield if block_given?

      redirect_to url_for([:edit, instance]), notice: t('.success')
    else
      render_turbo('form')
    end
  end

  private

  attr_reader :instance

  def search_params
    params[:q]
  end

  def permitted_params
    raise NotImplemented
  end

  def resource = controller_name.classify.safe_constantize

  def set_reader
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

  def instance_variable_name = "@#{variable_name}"
  def variable_name = controller_name.singularize

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

      build_nested_associations(instance, association)
    end
  end

  def build_nested_associations(instance_obj, nested)
    association = instance_obj.send(nested)

    return instance_obj.send("build_#{nested}") if association.nil?

    association_built = association.build

    association_built.nested_attributes_options.each_key do |built_nested|
      build_nested_associations(association_built, built_nested)
    end
  end
end
