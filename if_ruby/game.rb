require 'if_ruby/parser'
require 'if_ruby/room'

module IFRuby
  class Game
    attr_accessor :parser

    attr_accessor :rooms

    def initialize
      @parser = Parser.new

      @rooms = EntityGroup.new

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
    room.instance_eval(&block) if block
    rooms.add(room)
  end
end

