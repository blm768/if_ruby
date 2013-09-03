require 'ifruby/entity.rb'

module IFRuby
  class Room < Entity
    def initialize(name)
      self.name = name
    end

    def description
      return nil
    end
  end
end
