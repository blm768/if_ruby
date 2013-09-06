require 'if_ruby/thing.rb'

module IFRuby
  class Room < Entity
    attr_accessor :things
    attr_accessor :links
    attr_accessor :visited

    def initialize(name)
      super(name)

      @things = EntityGroup.new(self)
      @links = {}
    end

    def thing(name, &block)
      thing = Thing.new(name)
      thing.instance_eval(&block) if block
      things.add(thing)
      thing
    end

    def room_description
      desc = self.description
      if desc
        desc = desc[0 .. -1]
      else
        desc = '[Error: no room description]'
      end

      non_player_things = things.reject{ |m| m.is_a?(Player) }
      if non_player_things.length > 0
        desc << "\n\nYou see "
        desc << non_player_things.en.conjunction
        desc << '.'
      end
      desc
    end

    def link(other_room, direction)
      links[direction] = other_room
    end

    def get_link(direction)
      link = links[direction]
      return unless link
      #If the link is stored as a string, convert it to a room.
      unless link.is_a?(Room)
        link = game.find_room(link)
        raise %{Unable to find room "#{link}"} unless link
        links[direction] = link
      end
      link
    end

    def find_things(name)
      things.find_all(name)
    end
  end
end

