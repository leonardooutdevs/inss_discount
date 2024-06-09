# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record, :access_permission_level

  def initialize(user, record)
    @user = user
    @record = record
    @access_permission_level = user.access_permission_levels.by(find_class)
  end

  def index? = access_permission_level.read?

  def show? = access_permission_level.read?

  def create? = access_permission_level.write?

  def new? = access_permission_level.write?

  def update? = access_permission_level.write?

  def edit? = access_permission_level.write?

  def destroy? = access_permission_level.admin?

  private

  def find_class
    if record.respond_to?(:to_sql)
      record.model.name
    else
      record.class.name
    end
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve = raise(NoMethodError, "You must define #resolve in #{self.class}")

    private

    attr_reader :user, :scope, :access_permission_level
  end
end
