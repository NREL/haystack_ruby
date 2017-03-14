module ProjectHaystack
  module Types
    module DateTime
      def set_fields str_value
        @haystack_type = 'DateTime'
        match = /\At:(.*)\z/.match str_value
        begin
          @value = DateTime.parse match[1]
        rescue Exception=>e
          raise "invalid ProjectHaystack::Types::DateTime #{str_value}.  Error #{e}"
        end
      end
    end
  end
end