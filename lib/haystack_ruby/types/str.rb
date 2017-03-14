module HaystackRuby
  module Types
    module Str
      def set_fields str_value
        @haystack_type = 'Str'
        match = /\As:(.*)\z/.match str_value
        raise "invalid HaystackRuby::Types::Str: #{str_value}" if match.nil?
        @value = match[1]
      end
    end
  end
end