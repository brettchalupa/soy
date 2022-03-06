# frozen_string_literal: true

module Soy
  # Utility methods to be used across classes
  module Helpers
    # Returns the time for executing the block, rounded to the sixth
    # place.
    def elapsed
      starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      yield
      ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      (ending - starting).round(6)
    end
  end
end
