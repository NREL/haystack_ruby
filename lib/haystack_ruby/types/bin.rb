module HaystackRuby
  module Types
    module Bin
      def set_fields str_value
        @haystack_type = 'Bin'
        match = /\Ab:(.*)\z/.match str_value
        raise HaystackRuby::Error, "invalid HaystackRuby::Types::Bin: #{str_value}" if match.nil?
        # Value is mime type
        @value = match[1]
      end
    end
  end
end