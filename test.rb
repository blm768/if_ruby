$LOAD_PATH << Dir.pwd

require 'ifruby'

include IFRuby

game = Game.new

game.require 'game/main.rb'

game.run()

