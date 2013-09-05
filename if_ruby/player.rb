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
        game.display.puts self.location.name
      else
        game.display.puts "You can't go that way."
      end
    end
  end
end

