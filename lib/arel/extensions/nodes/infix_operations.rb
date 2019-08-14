# frozen_string_literal: true

module Arel
  module Extensions
    module Nodes
      class Exponentiation < Arel::Nodes::InfixOperation
        def initialize left, right
          super(:'^', left, right)
        end
      end

      class Modulo < Arel::Nodes::InfixOperation
        def initialize left, right
          super(:%, left, right)
        end
      end

      class Tsearch < Arel::Nodes::InfixOperation
        def initialize left, right
          super(:'@@', left, right)
        end
      end
    end
  end

  module Predications
    def modulo other
      Extensions::Nodes::Modulo.new self, other
    end

    def exponentiation other
      Extensions::Nodes::Exponentiation.new self, other
    end
    alias :pow :exponentiation
    alias :power_of :exponentiation

    def tsearch other
      Extensions::Nodes::Tsearch.new self, other
    end
  end
end
