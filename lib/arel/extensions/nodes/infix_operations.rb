# frozen_string_literal: true

module Arel
  module Extensions
    module Nodes
      class Exponentiation < Arel::Nodes::InfixOperation
        def initialize left, right
          super(:'^', left, right)
        end
      end

      class Match < Arel::Nodes::InfixOperation
        def initialize left, right
          super(:'@@', left, right)
        end
      end

      class Exists < Arel::Nodes::InfixOperation
        def initialize left, right
          super(:'@?', left, right)
        end
      end
    end
  end

  module Predications
    def exponentiation other
      Extensions::Nodes::Exponentiation.new self, other
    end

    def tsearch other
      Extensions::Nodes::Match.new self, other
    end

    def json_path_exists other
      Extensions::Nodes::Exists.new self, other
    end

    def json_path_match other
      Extensions::Nodes::Match.new self, other
    end
  end
end
