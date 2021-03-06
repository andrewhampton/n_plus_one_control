# frozen_string_literal: true

module NPlusOneControl
  module RSpec
    # Includes scale method into RSpec Example
    module DSL
      # Extends RSpec ExampleGroup with populate & warmup methods
      module ClassMethods
        # Setup warmup block, wich will run before matching
        # for example, if using cache, then later queries
        # will perform less DB queries than first
        def warmup
          return @warmup unless block_given?

          @warmup = Proc.new
        end

        # Setup populate callback, which is used
        # to prepare data for each run.
        def populate
          return @populate unless block_given?

          @populate = Proc.new
        end
      end

      attr_accessor :executor

      def current_scale
        executor&.current_scale
      end
    end
  end
end
