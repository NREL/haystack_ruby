module ProjectHaystack
  module Types
    module DateTime
      def set_fields str_value
        @haystack_type = 'DateTime'
        match = /\At:(.*)\z/.match str_value
        try
          @value = DateTime.parse match[1]
        catch Exception=>e
          raise "invalid ProjectHaystack::Types::DateTime #{str_value}.  Error #{e}"
        end
      end
    end
  end
end