# frozen_string_literal: true

require 'arel/visitors/postgresql'

module Arel
  module Extensions
    module Visitors
      module ToSql
        private

          def visit_Arel_Extensions_Nodes_Cast o, collector
            collector << 'CAST('
            visit(o.expr, collector) << ' AS '
            visit(o.type, collector) << ')'
          end

          def visit_Arel_Extensions_Nodes_Factorial o, collector
            visit(o.expr, collector) << ' !'
          end

          def visit_Arel_Extensions_Nodes_Exists o, collector
            collector = visit o.left, collector
            collector << ' @? '

            right = if o.right.is_a?(String)
              ::Arel::Nodes.build_quoted(o.right)
            else
              o.right
            end

            visit right, collector
          end

          def visit_Arel_Extensions_Nodes_Match o, collector
            collector = visit o.left, collector
            collector << ' @@ '

            right = if o.right.is_a?(String)
              ::Arel::Nodes.build_quoted(o.right)
            else
              o.right
            end

            visit right, collector
          end

          def visit_Arel_Extensions_Nodes_NullsFirst o, collector
            visit o.value, collector
            collector << ' NULLS FIRST'
          end

          def visit_Arel_Extensions_Nodes_NullsLast o, collector
            visit o.value, collector
            collector << ' NULLS LAST'
          end





          def visit_Arel_Extensions_Nodes_Abs o, collector
            "ABS(#{o.expressions.map { |x|
              visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
          end

          def visit_Arel_Extensions_Nodes_Cbrt o
            "CBRT(#{o.expressions.map { |x|
              visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
          end

          def visit_Arel_Extensions_Nodes_Ceil o
            "CEIL(#{o.expressions.map { |x|
              visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
          end

          def visit_Arel_Extensions_Nodes_Degrees o
            "DEGREES(#{o.expressions.map { |x|
              visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
          end

          def visit_Arel_Extensions_Nodes_Div o
          end

          def visit_Arel_Extensions_Nodes_Exp o
            "EXP(#{o.expressions.map { |x|
              visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
          end

          def visit_Arel_Extensions_Nodes_Floor o
            "FLOOR(#{o.expressions.map { |x|
              visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
          end

          def visit_Arel_Extensions_Nodes_Ln o
            "LN(#{o.expressions.map { |x|
              visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
          end

          def visit_Arel_Extensions_Nodes_Log o
          end

          def visit_Arel_Extensions_Nodes_Mod o
          end

          def visit_Arel_Extensions_Nodes_Pi o
            "PI()#{o.alias ? " AS #{visit o.alias}" : ''}"
          end

          def visit_Arel_Extensions_Nodes_Power o
          end

          def visit_Arel_Extensions_Nodes_Radians o
            "LN(#{o.expressions.map { |x|
              visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
          end

          def visit_Arel_Extensions_Nodes_Random o
            "RANDOM()#{o.alias ? " AS #{visit o.alias}" : ''}"
          end

          def visit_Arel_Extensions_Nodes_Round o
          end

          def visit_Arel_Extensions_Nodes_Setseed o
            "SETSEED(#{o.expressions.map { |x|
              visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
          end

          def visit_Arel_Extensions_Nodes_Sign o
            "SIGN(#{o.expressions.map { |x|
              visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
          end

          def visit_Arel_Extensions_Nodes_Sqrt o
            "SQRT(#{o.expressions.map { |x|
              visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
          end

          def visit_Arel_Extensions_Nodes_Trunc o
          end

          def visit_Arel_Extensions_Nodes_WidthBucket o
          end
      end
    end
  end

  Visitors::ToSql.include(Arel::Extensions::Visitors::ToSql)
end
