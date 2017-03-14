module ProjectHaystack
  module Types
    module Date
      def set_fields str_value
        @haystack_type = 'Date'
        match = /\Ad:([-0-9]*)\z/.match str_value
        try
          @value = Date.parse match[1]
        catch Exception=>e
          raise "invalid ProjectHaystack::Types::Date #{str_value}.  Error #{e}"
        end
      end
    end
  end
end