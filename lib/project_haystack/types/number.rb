module ProjectHaystack
  module Types
    module Number
      def set_fields str_value
        @haystack_type = 'Number'
        match = /\An:([0-9\.]*) (.*)\z/.match str_value
        raise "invalid ProjectHaystack::Types::Number: #{str_value}" if match.nil?
        @value = match[1].to_f
        # also set unit for Number
        @unit = match[2]
      end
    end
  end
end