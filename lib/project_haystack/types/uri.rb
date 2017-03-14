module ProjectHaystack
  module Types
    module Uri
      def set_fields str_value
        @haystack_type = 'Uri'
        match = /\Au:(.*)\z/.match str_value
        raise "invalid ProjectHaystack::Types::Uri: #{str_value}" if match.nil?
        @value = match[1]
      end
    end
  end
end