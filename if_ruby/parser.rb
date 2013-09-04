module IFRuby
  class Parser
    attr_reader :game
    attr_accessor :verbs

    def initialize(game)
      @game = game
      @verbs = {}
    end

    def parse(str)
      str.strip!
      #words = str.split(' ')
    end
  end

  class Verb
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end

