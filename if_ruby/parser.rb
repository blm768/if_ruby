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
        return
      end
      words = str.split(' ')
      verb = verbs[words[0]]
      unless verb
        game.display.puts @unknown_verb_message
        return
      end
      words = words[0 .. -1]
      verb.execute(words)
    end

    def add_verb(verb)
      name = verb.name
      raise %{The verb "#{name}" already exists.} if verbs[name]
      verbs[name] = verb
    end

    def alias_verb(names)
      names.each_pair do |old_name, new_name|
        verb = verbs[old_name]
        raise %{Unknown verb "#{old_name}"} unless verb
        verbs[new_name] = verb
      end
    end
  end

  class Verb
    attr_reader :name

    def initialize(name, &block)
      @name = name
      self.define_singleton_method(:execute) do |words|
        block.call(words)
      end
    end
  end
end

