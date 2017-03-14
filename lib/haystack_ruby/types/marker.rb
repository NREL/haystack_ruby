module HaystackRuby
  module Types
    module Marker
      def set_fields str_value
        @haystack_type = 'Marker'
        @value = true
      end
    end
  end
end