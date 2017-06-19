module HaystackRuby
  module Types
    module Number
      def set_fields str_value
        @haystack_type = 'Number'
        match = /\An:([-0-9\.]*)( .*)*\z/.match str_value
        raise HaystackRuby::Error, "invalid HaystackRuby::Types::Number: #{str_value}" if match.nil?
        @value = match[1].to_f
        # also set unit if available
        @unit = match[2].strip if match[2].present?
      end
    end
  end
end