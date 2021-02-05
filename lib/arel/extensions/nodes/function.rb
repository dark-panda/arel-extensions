# frozen_string_literal: true

module Arel
  %w(
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
  ).each do |function|
    Extensions::Nodes.const_set(function, Class.new(Arel::Nodes::Function))

    ::Arel::Predications.class_eval(<<~RUBY, __FILE__, __LINE__ + 1)
      def #{function.downcase}(*args)
        Extensions::Nodes::#{function}.new [self, *args]
      end
    RUBY
  end

  module Predications
    alias absolute abs
    alias cube_root cbrt
    alias log_10 log10
    alias modulo mod
    alias pow power
    alias power_of power
    alias square_root sqrt
    alias width_bucket widthbucket
  end
end
