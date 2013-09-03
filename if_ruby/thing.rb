require 'if_ruby/entity.rb'

module IFRuby
  class Thing < Entity
    attr_accessor :attributes

    def initialize(name)
      super(name)

      @attributes = Set.new
    end

    def attribute(att)
      @attributes.add(att)
    end
  end
end

