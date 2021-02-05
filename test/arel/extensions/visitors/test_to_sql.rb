# frozen_string_literal: true

require 'test_helper'

module Arel
  module Visitors
    describe 'the to_sql visitor' do
      before do
        @visitor = ToSql.new Table.engine.connection
        @table = Table.new(:users)
        @attr = @table[:id]
      end

      def compile(node)
        @visitor.accept(node, Collectors::SQLString.new).value
      end

      describe 'predications' do
        before do
          @node = Table.new(:products)[:price]
        end

        it 'should handle exponentiation' do
          sql = @node.exponentiation 10
          expect(compile(sql)).must_equal %("products"."price" ^ 10)
        end

        it 'should handle cast' do
          sql = @node.cast('geometry')
          expect(compile(sql)).must_equal %{CAST("products"."price" AS geometry)}
        end

        it 'should handle absolute' do
          sql = @node.absolute
          expect(compile(sql)).must_equal %(ABS("products"."price"))
        end

        it 'should handle abs' do
          sql = @node.abs
          expect(compile(sql)).must_equal %(ABS("products"."price"))
        end

        it 'should handle cbrt' do
          expect(compile(@node.cbrt)).must_equal %(CBRT("products"."price"))
        end

        it 'should handle cube_root' do
          expect(compile(@node.cube_root)).must_equal %(CBRT("products"."price"))
        end

        it 'should handle ceil' do
          expect(compile(@node.ceil)).must_equal %(CEIL("products"."price"))
        end

        it 'should handle degrees' do
          expect(compile(@node.degrees)).must_equal %(DEGREES("products"."price"))
        end

        it 'should handle div' do
          expect(compile(@node.div(10))).must_equal %(DIV("products"."price", 10))
        end

        it 'should handle exp' do
          expect(compile(@node.exp)).must_equal %(EXP("products"."price"))
        end

        it 'should handle factorial' do
          expect(compile(@node.factorial)).must_equal %(FACTORIAL("products"."price"))
        end

        it 'should handle floor' do
          expect(compile(@node.floor)).must_equal %(FLOOR("products"."price"))
        end

        it 'should handle ln' do
          expect(compile(@node.ln)).must_equal %(LN("products"."price"))
        end

        it 'should handle log' do
          expect(compile(@node.log)).must_equal %(LOG("products"."price"))
        end

        it 'should handle log10' do
          expect(compile(@node.log10)).must_equal %(LOG10("products"."price"))
        end

        it 'should handle log_10' do
          expect(compile(@node.log_10)).must_equal %(LOG10("products"."price"))
        end

        it 'should handle mod' do
          expect(compile(@node.mod(10))).must_equal %(MOD("products"."price", 10))
        end

        it 'should handle modulo' do
          expect(compile(@node.modulo(10))).must_equal %(MOD("products"."price", 10))
        end

        it 'should handle power' do
          expect(compile(@node.power(10))).must_equal %(POWER("products"."price", 10))
        end

        it 'should handle pow' do
          expect(compile(@node.pow(10))).must_equal %(POWER("products"."price", 10))
        end

        it 'should handle power_of' do
          expect(compile(@node.power_of(10))).must_equal %(POWER("products"."price", 10))
        end

        it 'should handle radians' do
          expect(compile(@node.radians)).must_equal %(RADIANS("products"."price"))
        end

        it 'should handle round' do
          expect(compile(@node.round)).must_equal %(ROUND("products"."price"))
        end

        it 'should handle round with an argument' do
          expect(compile(@node.round(3))).must_equal %(ROUND("products"."price", 3))
        end

        it 'should handle scale' do
          expect(compile(@node.scale)).must_equal %(SCALE("products"."price"))
        end

        it 'should handle sign' do
          expect(compile(@node.sign)).must_equal %(SIGN("products"."price"))
        end

        it 'should handle sqrt' do
          expect(compile(@node.sqrt)).must_equal %(SQRT("products"."price"))
        end

        it 'should handle square_root' do
          expect(compile(@node.square_root)).must_equal %(SQRT("products"."price"))
        end

        it 'should handle trunc' do
          expect(compile(@node.trunc(10))).must_equal %(TRUNC("products"."price", 10))
        end

        it 'should handle widthbucket' do
          expect(compile(@node.widthbucket(10, 20, 30))).must_equal %(WIDTHBUCKET("products"."price", 10, 20, 30))
        end

        it 'should handle width_bucket' do
          expect(compile(@node.width_bucket(10, 20, 30))).must_equal %(WIDTHBUCKET("products"."price", 10, 20, 30))
        end

        it 'should handle acos' do
          expect(compile(@node.acos)).must_equal %(ACOS("products"."price"))
        end

        it 'should handle asin' do
          expect(compile(@node.asin)).must_equal %(ASIN("products"."price"))
        end

        it 'should handle atan' do
          expect(compile(@node.atan)).must_equal %(ATAN("products"."price"))
        end

        it 'should handle atan2' do
          expect(compile(@node.atan2 )).must_equal %(ATAN2("products"."price"))
        end

        it 'should handle cos' do
          expect(compile(@node.cos)).must_equal %(COS("products"."price"))
        end

        it 'should handle cot' do
          expect(compile(@node.cot)).must_equal %(COT("products"."price"))
        end

        it 'should handle sin' do
          expect(compile(@node.sin)).must_equal %(SIN("products"."price"))
        end

        it 'should handle tan' do
          expect(compile(@node.tan)).must_equal %(TAN("products"."price"))
        end

        it 'should handle sinh' do
          expect(compile(@node.sinh)).must_equal %(SINH("products"."price"))
        end

        it 'should handle cosh' do
          expect(compile(@node.cosh)).must_equal %(COSH("products"."price"))
        end

        it 'should handle tanh' do
          expect(compile(@node.tanh)).must_equal %(TANH("products"."price"))
        end

        it 'should handle asinh' do
          expect(compile(@node.asinh)).must_equal %(ASINH("products"."price"))
        end

        it 'should handle acosh' do
          expect(compile(@node.acosh)).must_equal %(ACOSH("products"."price"))
        end

        it 'should handle atanh' do
          expect(compile(@node.atanh)).must_equal %(ATANH("products"."price"))
        end

        it 'should handle tsearch' do
          sql = @table[:tsearch].tsearch('foo bar')
          expect(compile(sql)).must_equal %("users"."tsearch" @@ 'foo bar')

          sql = @table[:tsearch].tsearch(Nodes.build_quoted('foo bar'))
          expect(compile(sql)).must_equal %("users"."tsearch" @@ 'foo bar')

          sql = @table[:tsearch].tsearch(Nodes::NamedFunction.new('plainto_tsquery', [Nodes.build_quoted('foo bar')]))
          expect(compile(sql)).must_equal %("users"."tsearch" @@ plainto_tsquery('foo bar'))
        end

        it 'should handle JSON path exists' do
          sql = @table[:data].json_path_exists('$.foo.bar')
          expect(compile(sql)).must_equal %("users"."data" @? '$.foo.bar')

          sql = @table[:data].json_path_exists(Nodes.build_quoted('$.foo.bar'))
          expect(compile(sql)).must_equal %("users"."data" @? '$.foo.bar')
        end

        it 'should handle JSON path match' do
          sql = @table[:data].json_path_match('$.foo.bar')
          expect(compile(sql)).must_equal %("users"."data" @@ '$.foo.bar')

          sql = @table[:data].json_path_match(Nodes.build_quoted('$.foo.bar'))
          expect(compile(sql)).must_equal %("users"."data" @@ '$.foo.bar')
        end

        it 'should handle nulls_first' do
          sql = @table[:foos].nulls_first
          expect(compile(sql)).must_equal %("users"."foos" NULLS FIRST)

          sql = @table[:foos].asc.nulls_first
          expect(compile(sql)).must_equal %("users"."foos" ASC NULLS FIRST)

          sql = @table[:foos].desc.nulls_first
          expect(compile(sql)).must_equal %("users"."foos" DESC NULLS FIRST)

          sql = Arel::Nodes::NamedFunction.new('foo', [1, 2]).asc.nulls_first
          expect(compile(sql)).must_equal %(foo(1, 2) ASC NULLS FIRST)

          sql = Arel::Attributes::Attribute.new(@table, 'foos').asc.nulls_first
          expect(compile(sql)).must_equal %("users"."foos" ASC NULLS FIRST)

          sql = Arel::Nodes::Case.new(@table[:foos]).asc.nulls_first
          expect(compile(sql)).must_equal %(CASE "users"."foos" END ASC NULLS FIRST)

          sql = Arel::Nodes::InfixOperation.new('+', @table[:foos], @table[:bars]).asc.nulls_first
          expect(compile(sql)).must_equal %("users"."foos" + "users"."bars" ASC NULLS FIRST)

          sql = Arel::Nodes::Ascending.new(@table[:foos]).nulls_first
          expect(compile(sql)).must_equal %("users"."foos" ASC NULLS FIRST)

          sql = Arel::Nodes::Descending.new(@table[:foos]).nulls_first
          expect(compile(sql)).must_equal %("users"."foos" DESC NULLS FIRST)

          sql = Arel::Nodes::SqlLiteral.new('foos').asc.nulls_first
          expect(compile(sql)).must_equal %(foos ASC NULLS FIRST)

          sql = Arel::Nodes::UnaryOperation.new('!', @table[:foos]).asc.nulls_first
          expect(compile(sql)).must_equal %( ! "users"."foos" ASC NULLS FIRST)
        end

        it 'should handle nulls_last' do
          sql = @table[:foos].nulls_last
          expect(compile(sql)).must_equal %("users"."foos" NULLS LAST)

          sql = @table[:foos].asc.nulls_last
          expect(compile(sql)).must_equal %("users"."foos" ASC NULLS LAST)

          sql = @table[:foos].desc.nulls_last
          expect(compile(sql)).must_equal %("users"."foos" DESC NULLS LAST)

          sql = Arel::Nodes::NamedFunction.new('foo', [1, 2]).asc.nulls_last
          expect(compile(sql)).must_equal %(foo(1, 2) ASC NULLS LAST)

          sql = Arel::Attributes::Attribute.new(@table, 'foos').asc.nulls_last
          expect(compile(sql)).must_equal %("users"."foos" ASC NULLS LAST)

          sql = Arel::Nodes::Case.new(@table[:foos]).asc.nulls_last
          expect(compile(sql)).must_equal %(CASE "users"."foos" END ASC NULLS LAST)

          sql = Arel::Nodes::InfixOperation.new('+', @table[:foos], @table[:bars]).asc.nulls_last
          expect(compile(sql)).must_equal %("users"."foos" + "users"."bars" ASC NULLS LAST)

          sql = Arel::Nodes::Ascending.new(@table[:foos]).nulls_last
          expect(compile(sql)).must_equal %("users"."foos" ASC NULLS LAST)

          sql = Arel::Nodes::Descending.new(@table[:foos]).nulls_last
          expect(compile(sql)).must_equal %("users"."foos" DESC NULLS LAST)

          sql = Arel::Nodes::SqlLiteral.new('foos').asc.nulls_last
          expect(compile(sql)).must_equal %(foos ASC NULLS LAST)

          sql = Arel::Nodes::UnaryOperation.new('!', @table[:foos]).asc.nulls_last
          expect(compile(sql)).must_equal %( ! "users"."foos" ASC NULLS LAST)
        end

        it 'should handle nulls with the :first argument' do
          sql = @table[:foos].nulls(:first)
          expect(compile(sql)).must_equal %("users"."foos" NULLS FIRST)
        end

        it 'should handle nulls with the :last argument' do
          sql = @table[:foos].nulls(:last)
          expect(compile(sql)).must_equal %("users"."foos" NULLS LAST)
        end

        it 'should handle nulls with anything else' do
          assert_raises ArgumentError do
            @table[:foos].nulls(:foo)
          end
        end
      end
    end
  end
end
