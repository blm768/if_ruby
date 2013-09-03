require 'if_ruby/entity.rb'

module IFRuby
  class Thing < Entity
    attr_accessor :attributes
    attr_accessor :adjectives
    attr_reader :location

    def location=(new_location)
      if @location
        remove
      end
      if new_location
        new_location.things.add(self)
      end
      @location = new_location
    end

    def initialize(name)
      super(name)

      @attributes = Set.new
    end

    def attribute(att)
      @attributes.add(att.intern)
    end

    def remove
      super.remove
    end
  end
end

