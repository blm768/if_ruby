require 'if_ruby/thing.rb'

module IFRuby
  class Room < Entity
    attr_accessor :things

    def initialize(name)
      super(name)

      @things = EntityGroup.new
    end

    def thing(name, &block)
      thing = Thing.new(name)
      thing.instance_eval(&block) if block
      things.add(thing)
    end
  end
end
