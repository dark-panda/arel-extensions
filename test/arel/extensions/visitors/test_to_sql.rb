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

        it 'should handle pow' do
          sql = @node.pow 10
          expect(compile(sql)).must_equal %("products"."price" ^ 10)
        end

        it 'should handle power_of' do
          sql = @node.power_of 10
          expect(compile(sql)).must_equal %("products"."price" ^ 10)
        end

        it 'should handle modulo' do
          sql = @node.modulo 10
          expect(compile(sql)).must_equal %("products"."price" % 10)
        end

        it 'should handle cast' do
          sql = @node.cast('geometry')
          expect(compile(sql)).must_equal %{CAST("products"."price" AS geometry)}
        end

        it 'should handle square_root' do
          sql = @node.square_root
          expect(compile(sql)).must_equal %( |/ "products"."price")
        end

        it 'should handle sqrt' do
          sql = @node.sqrt
          expect(compile(sql)).must_equal %( |/ "products"."price")
        end

        it 'should handle cube_root' do
          sql = @node.cube_root
          expect(compile(sql)).must_equal %( ||/ "products"."price")
        end

        it 'should handle cbrt' do
          sql = @node.cbrt
          expect(compile(sql)).must_equal %( ||/ "products"."price")
        end

        it 'should handle factorial' do
          sql = @node.factorial
          expect(compile(sql)).must_equal %("products"."price" !)
        end

        it 'should handle fact' do
          sql = @node.fact
          expect(compile(sql)).must_equal %("products"."price" !)
        end

        it 'should handle factorial prefix' do
          sql = @node.factorial_prefix
          expect(compile(sql)).must_equal %( !! "products"."price")
        end

        it 'should handle fact prefix' do
          sql = @node.fact_prefix
          expect(compile(sql)).must_equal %( !! "products"."price")
        end

        it 'should handle absolute' do
          sql = @node.absolute
          expect(compile(sql)).must_equal %( @ "products"."price")
        end

        it 'should handle abs' do
          sql = @node.abs
          expect(compile(sql)).must_equal %( @ "products"."price")
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
