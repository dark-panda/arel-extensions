# frozen_string_literal: true

module Arel
  module Extensions::Nodes
    class Pi < Arel::Nodes::Function
      def initialize aliaz = nil
        @alias = aliaz && SqlLiteral.new(aliaz)
      end
    end

    %w(
      Abs
      Cbrt
      Ceil
      Degrees
      Div
      Exp
      Floor
      Ln
      Log
      Mod
      Power
      Radians
      Random
      Round
      Setseed
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
    ).each do |name|
      const_set(name, Class.new(Arel::Nodes::Function))
    end
  end
end
