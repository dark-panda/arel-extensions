# frozen_string_literal: true

module Arel
  module Extensions
    module Nodes
      class NullsFirst < ::Arel::Nodes::Unary
        # no-op
      end

      class NullsLast < ::Arel::Nodes::Unary
        # no-op
      end
    end

    module OrderPredications
      def nulls_first
        Extensions::Nodes::NullsFirst.new self
      end

      def nulls_last
        Extensions::Nodes::NullsLast.new self
      end

      def nulls(value)
        case value
          when :first
            nulls_first
          when :last
            nulls_last
          else
            raise ArgumentError, 'Expected one of :first or :last'
        end
      end
    end
  end

  [
    Attributes::Attribute,
    Nodes::Case,
    Nodes::Function,
    Nodes::InfixOperation,
    Nodes::Ordering,
    Nodes::SqlLiteral,
    Nodes::UnaryOperation
  ].each do |klass|
    klass.include(Extensions::OrderPredications)
  end
end
