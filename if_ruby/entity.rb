require 'set'

module IFRuby
  ##
  # Represents a concrete or abstract entity in the game world
  class Entity
    attr_reader :name
    attr_reader :alt_names
    ##
    #Should not be modified by the user
    attr_accessor :parent_group

    def initialize(name)
      @name = name.intern
      @alt_names = Set.new
    end

    def description(value = nil, &block)
      if value && block
        # TODO: raise a "real" exception.
        raise 'Description cannot be given as both a string and a block.'
      end
      if value
        @description = value
        #TODO: use a Proc instead of a method?
      elsif block
        @description = nil
        define_singleton_method(:get_description, &block)
      else
        return @description || (if defined?(get_description) then get_description else nil end)
      end
    end

    def parent
      parent_group.owner
    end

    def remove
      @parent_group.remove(self)
    end

    def to_s
      name.to_s
    end
  end

  class EntityGroup
    include Enumerable
    attr_accessor :owner

    def initialize(owner)
      @members = {}
      @names = {}
      @owner = owner
    end

    def [](name)
      return @members[name] || Set.new
    end

    def add(entity)
      add_with_name(entity, entity.name)
      entity.parent_group = self
    end

    ##
    # Adds an entity under the provided name (utility method for #add)
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

      #Note: currently sub-optimal when this method is called multiple times by #add
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
      @members[entity.name].delete(entity)
      entity.parent_group = nil
    end

    def find_unique(name)
      name = name.intern
      matches = self[name]
      return if not matches || matches.length == 0
      raise %{Unable to find unique entity with name "#{name}" in #{owner}} unless matches.length == 1
      #Return the first (and only) match.
      matches.each do |match|
        return match
      end
    end

    def find_all(name)
      name = name.intern
      self[name].clone || Set.new
    end

    def members
      @names.keys
    end

    def each
      @names.each_key do |key|
        yield key
      end
    end

    alias_method :each_member, :each

    def length
      @names.length
    end

    def to_s
      self.to_a.en.conjunction
    end
  end
end

