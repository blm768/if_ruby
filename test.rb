$LOAD_PATH << Dir.pwd

require 'if_ruby'

include IFRuby

game.require 'game/main.rb'

game.run()

