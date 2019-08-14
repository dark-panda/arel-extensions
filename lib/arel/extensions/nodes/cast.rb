# frozen_string_literal: true

module Arel
  module Extensions::Nodes
    class Cast < Arel::Nodes::Node
      attr_accessor :expr, :type

      def initialize expr, type
        @expr = expr
        @type = type && ::Arel::Nodes::SqlLiteral.new(type)
      end
    end
  end

  module Predications
    def cast other
      Extensions::Nodes::Cast.new self, other
    end
  end
end
