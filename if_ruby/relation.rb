require 'set'

module IFRuby
  class RelationType
    attr_reader :forward_symbol, :reverse_symbol
  end

  ##
  # Models a relationship between two Entities
  class Relation
    attr_reader :type
    attr_reader :first, :second

    def initialize(type, first, second)
      @type = type
      @first = first
      @second = second

      first.relations[relation_type.forward_symbol].add(self)
      second.relations[relation_type.reverse_symbol].add(self)
    end
  end

  ##
  # Mixin for objects that can be members of Relations
  module RelationTarget
    ##
    # Relations (by type symbol)
    def relations
      relations ||= Hash.new do { |hash, key| hash[key] = Set.new }
    end
  end

  ##
  # A set of relations organized by forward/reverse symbol
  class RelationSet
    def initialize
      @relations = {}
    end

    def add(relation)
      forward_rel = @relations[relation.forward_symbol]
      reverse_rel = @relations[relation.reverse_symbol]
      if forward_rel && forward_rel != relation
        raise ArgumentError.new("Relation set already contains #{relation.forward_symbol} as a forward relation")
      end
      if reverse_rel && reverse_rel != relation
        raise ArgumentError.new("Relation set already contains #{relation.forward_symbol} as a reverse relation")
      end
      @relations[relation.forward_symbol] = relation
      @relations[relation.reverse_symbol] = relation
    end

    def remove(relation)
      forward_rel = @relations[relation.forward_symbol]
      if forward_rel && forward_rel == relation
        @relations.delete(relation.forward_symbol)
      end
      reverse_rel = @relations[relation.reverse_symbol]
      if reverse_rel && reverse_rel == relation
        @relations.delete(relation.reverse_symbol)
      end
    end

    def get(symbol)
      @relations[symbol]
    end
  end
end
