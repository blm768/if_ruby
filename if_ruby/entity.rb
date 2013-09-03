require 'set'

module IFRuby
  class Entity
    attr_reader :name
    attr_reader :alt_names
    attr_accessor :parent

    def initialize(name)
      @name = name.intern
      @alt_names = Set.new
    end
    
    def description(value = nil, &block)
      if value && block
        raise "Description cannot be given as both a string and a block."
      end
      if value
        @description = value
      elsif block
        @description = nil
        define_singleton_method(:get_description, &block)
      else
        return @description || (if defined?(get_description) then get_description else nil end)
      end
    end

    def remove
      @parent.remove(self)
    end
  end

  class EntityGroup
    def initialize
      @members = {}
      @names = {}
    end

    def [](name)
      return @members[name]
    end

    def add(entity)
      add_with_name(entity, entity.name)
    end

    ##
    #Adds an entity under the provided name
    #
    #The name should be a symbol.
    def add_with_name(entity, name)
      members = @members[name]
      if members
        members.add(entity)
      else
        members = Set.new
        members.add(entity)
        @members[name] = members
      end

      names = @names[entity]
      if names
        names.add(name)
      else
        names = Set.new
        names.add(name)
        @names[entity] = names
      end
    end

    protected :add_with_name

    def remove(entity)
      #TODO: handle semantics of removing an element that is not in the group?
      @names.delete(entity)
      @members[entity.name].remove(entity)
    end

    def find_unique(name)
      name = name.intern
      matches = self[name]
      return nil unless matches && matches.length == 1
      #Return the first (and only) match.
      matches.each do |match|
        return match
      end
    end
  end
end

