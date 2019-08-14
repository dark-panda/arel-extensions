# frozen_string_literal: true

module Arel
  module Extensions
    module Nodes
      class SquareRoot < ::Arel::Nodes::UnaryOperation
        def initialize operand
          super(:'|/', operand)
        end
      end

      class CubeRoot < ::Arel::Nodes::UnaryOperation
        def initialize operand
          super(:'||/', operand)
        end
      end

      class Factorial < ::Arel::Nodes::UnaryOperation
        def initialize operand
          super(:'!', operand)
        end
      end

      class FactorialPrefix < ::Arel::Nodes::UnaryOperation
        def initialize operand
          super(:'!!', operand)
        end
      end

      class Absolute < ::Arel::Nodes::UnaryOperation
        def initialize operand
          super(:'@', operand)
        end
      end
    end
  end

  module Predications
    def square_root
      Extensions::Nodes::SquareRoot.new self
    end
    alias :sqrt :square_root

    def cube_root
      Extensions::Nodes::CubeRoot.new self
    end
    alias :cbrt :cube_root

    def factorial
      Extensions::Nodes::Factorial.new self
    end
    alias :fact :factorial

    def factorial_prefix
      Extensions::Nodes::FactorialPrefix.new self
    end
    alias :fact_prefix :factorial_prefix

    def absolute
      Extensions::Nodes::Absolute.new self
    end
    alias :abs :absolute
  end
end
