module IFRuby
  class Parser
    attr_reader :game
    attr_accessor :verbs
    attr_accessor :no_input_message
    attr_accessor :unknown_verb_message

    def initialize(game)
      @game = game
      @verbs = {}

      @no_input_message = 'Huh?'
      @unknown_verb_message = 'Huh?'
    end

    def parse(str)
      str.strip!
      if str.length == 0
        game.display.puts @no_input_message
      end
      words = str.split(' ')
      verb = verbs[words[0]]
      unless verb
        game.display.puts @unknown_verb_message
        return
      end
      words = words[0 .. -1]
      verb.execute.call(words)
    end

    def add_verb(verb)
      name = verb.name
      raise %{The verb "#{name}" already exists.} if verbs[name]
      verbs[name] = verb
    end
  end

  class Verb
    attr_reader :name
    attr_accessor :execute

    def initialize(name)
      @name = name
    end
  end
end

