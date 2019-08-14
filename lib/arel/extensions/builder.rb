# frozen_string_literal: true

module Arel::Extensions
  class Builder
    attr_accessor :current

    def self.build
      yield new
    end

    def build
      @current = yield self
    end

    private def method_missing(name, *args, &block)
      function(name, *args, &block)
    end

    def to_sql
      @current.to_sql if @current
    end

    def function(name, *args, &block)
      Arel::Nodes::NamedFunction.new(name, args)
    end

    def cast(expr, type)
      Arel::Extensions::Nodes::Cast.new(expr, type)
    end
  end
end
