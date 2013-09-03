$LOAD_PATH << Dir.pwd

require 'if_ruby'

include IFRuby

game = Game.new

game.require 'game/main.rb'

game.run()

