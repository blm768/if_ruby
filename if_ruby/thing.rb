require 'if_ruby/entity.rb'

module IFRuby
  class Thing < Entity
    attr_accessor :attributes
    attr_accessor :adjectives

    def initialize(name)
      super(name)

      @attributes = Set.new
    end

    def attribute(att)
      @attributes.add(att.intern)
    end
  end
end

