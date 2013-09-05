require 'if_ruby/thing.rb'

module IFRuby
  class Room < Entity
    attr_accessor :things
    attr_accessor :links

    def initialize(name)
      super(name)

      @things = EntityGroup.new
      @links = {}
    end

    def thing(name, &block)
      thing = Thing.new(name)
      thing.instance_eval(&block) if block
      things.add(thing)
      thing
    end

    def room_description
      desc = self.description || '[Error: no room description]'

      if things.length > 0
        desc << "\n\nYou see "
        desc << things.reject{ |m| m.is_a?(Player) }.en.conjunction
        desc << '.'
      end
    end

    def link(direction, other_room)
      links[direction] = game.find_room(other_room)
    end
  end
end
