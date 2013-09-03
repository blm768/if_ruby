require 'if_ruby/thing.rb'
require 'if_ruby/room.rb'

module IFRuby
  class Player < Thing
    def initialize
      super('player')
    end
  end
end

