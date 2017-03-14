module ProjectHaystack
  module Types
    # Since there is no Ruby Hour class, value is a string "hr:minute"
    module Time
      def set_fields str_value
        @haystack_type = 'Time'
        match = /\Ah:([0-9:]*)\z/.match str_value
        try
          @value = match[1]
        catch Exception=>e
          raise "invalid ProjectHaystack::Types::Time #{str_value}.  Error #{e}"
        end
      end
    end
  end
end