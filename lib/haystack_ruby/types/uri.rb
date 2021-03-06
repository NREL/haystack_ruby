module HaystackRuby
  module Types
    module Uri
      def set_fields str_value
        @haystack_type = 'Uri'
        match = /\Au:(.*)\z/.match str_value
        raise HaystackRuby::Error, "invalid HaystackRuby::Types::Uri: #{str_value}" if match.nil?
        @value = match[1]
      end
    end
  end
end