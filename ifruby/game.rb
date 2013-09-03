require 'set'
require 'yaml'

require 'ifruby/parser'
require 'ifruby/room'

module IFRuby
  class Game
    attr_accessor :parser

    attr_accessor :rooms

    def initialize
      @parser = Parser.new

      @rooms = {}

      @required_files = Set.new
    end
  end

  def require(filename)
    return if @required_files.include?(filename)
    @required_files.add(filename)
    file = File.open(filename, 'r')
    instance_eval(file.read, filename)
  end

  def run

  end

  def room(name, &block)
    room = Room.new(name)
    room.instance_eval(&block) if block_given?
    raise %{A room with the specified name ("#{name}") already exists.} if rooms[name]
    rooms[name.intern] = room
  end
end

