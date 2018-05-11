require 'singleton'

require 'linguistics'

require 'if_ruby/display'
require 'if_ruby/parser'
require 'if_ruby/player'
require 'if_ruby/room'

module IFRuby
  def game
    Game.instance
  end

  class Game
    include Singleton

    attr_reader :parser
    attr_reader :display

    attr_accessor :rooms
    attr_reader :player

    def initialize
      @parser = Parser.new(self)

      @rooms = EntityGroup.new(self)
      @player = Player.new

      @required_files = Set.new

      Linguistics.use(:en)

      # TODO: don't hard-code this?
      self.require 'if_ruby/verbs.rb'
    end

    def require(filename)
      return if @required_files.include?(filename)
      @required_files.add(filename)
      file = File.open(filename, 'r')
      instance_eval(file.read, filename)
    end

    def run
      @display = CursesDisplay.new
      @running = true
      display.puts player.location.room_description
      while @running do
        command = display.gets
        parser.parse(command)
      end
    ensure
      @display.close() if @display
      @display = nil
    end

    def quit
      @running = false
    end

    ##
    #Finds a room by name
    #
    #If given a Room instead of a name, returns the Room
    def find_room(room)
      return room if room.is_a?(Room) || room == nil
      rooms.find_unique(room.to_s)
    end

    def room(name, &block)
      room = Room.new(name)
      room.instance_eval(&block) if block
      rooms.add(room)
      room
    end

    def verb(name, &block)
      verb = Verb.new(name, &block)
      parser.add_verb(verb)
    end
    
    def alias_verb(names)
      parser.alias_verb(names)
    end
  end
end

