module Resourceful
  module ClassMethods
    ACTIONS = %i[index show new edit create update destroy].freeze

    Options = Struct.new(
      :acts,
      :include_nesteds,
      :columns,
      :scopes,
      :tables,
      :decorate,
      :turbo,
      :scope,
      :order,
      keyword_init: true
    ) do
      def initialize(...)
        super

        self.acts ||= (ACTIONS - (opts[:except].presence || []).to_a)
        self.scopes = scopes.to_a.presence || [:all]
      end
    end

    attr_accessor :options

    delegate(
      :acts,
      :include_nesteds,
      :columns,
      :scopes,
      :tables,
      :decorate,
      :turbo,
      :scope,
      :order,
      to: :options
    )

    def resourceful(opts = {})
      self.options = Options.new(
        opts.slice(:include_nesteds, :columns, :scopes, :tables, :decorate, :turbo, :scope, :order)
            .merge(acts: (opts[:only].presence || (ACTIONS - (opts[:except].presence || []).to_a)).to_a)
      )

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
end
