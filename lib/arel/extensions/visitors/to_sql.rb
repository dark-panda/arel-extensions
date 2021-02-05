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

          %w{
            Abs
            Cbrt
            Ceil
            Degrees
            Div
            Exp
            Factorial
            Floor
            Ln
            Log
            Log10
            Mod
            Power
            Radians
            Round
            Scale
            Sign
            Sqrt
            Trunc
            WidthBucket

            Acos
            Asin
            Atan
            Atan2
            Cos
            Cot
            Sin
            Tan

            Sinh
            Cosh
            Tanh
            Asinh
            Acosh
            Atanh
          }.each do |function|
            class_eval(<<~RUBY, __FILE__, __LINE__ + 1)
              def visit_Arel_Extensions_Nodes_#{function} o, collector
                collector << '#{function.upcase}('
                collector = visit(o.expressions, collector) << ')'
                if o.alias
                  collector << ' AS '
                  visit o.alias, collector
                else
                  collector
                end
              end
            RUBY
          end
      end
    end
  end

  Visitors::ToSql.include(Arel::Extensions::Visitors::ToSql)
end
