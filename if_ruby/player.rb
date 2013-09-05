require 'if_ruby/thing.rb'
require 'if_ruby/room.rb'

module IFRuby
  class Player < Thing
    def initialize
      super('player')
    end

    def go(direction)
      new_location = location.get_link(direction)
      if new_location
        self.location = new_location
        game.display.puts new_location.name
        unless new_location.visited
          game.display.puts new_location.room_description
          new_location.visited = true
        end
      else
        game.display.puts "You can't go that way."
      end
    end
  end
end

