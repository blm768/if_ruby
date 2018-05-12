# TODO: integrate Docile gem.

module IFRuby
  ##
  # A base class for objects that provide a "construction DSL" for other classes
  class Builder
    def initialize
      @init_attrs = {}
    end

    def self.initializer(&block)
      self.define_singleton_method(:initialize_instance, &block)
    end

    # TODO: determine whether this is actually useful enough to have.
    def self.init_attr(name)
      self.define_method(name) do |value|
        raise InitializationOrderError::new(name) unless @built.nil?
        @init_attrs[name] = value
      end
    end

    def self.attr_setter(name)
      setter_name = "#{name}=".intern
      self.define_method(name) do |value|
        @built ||= self.class.initialize_instance(@init_attrs)
        @built.method(setter_name).call(value)
      end
    end

    def build(&block)
      self.instance_eval(&block)
      @built ||= self.class.initialize_instance(@init_attrs)
    end
  end

  ##
  # Raised when a builder instance tries to set an initialization
  # attribute after intialization has occurred
  class InitializationOrderError < RuntimeError
    def initialize(attr_name)
      super("Cannot set initializer attribute #{attr_name} after initialization has occurred")
    end
  end
end
