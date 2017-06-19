module HaystackRuby
  module Types
    module Date
      def set_fields str_value
        @haystack_type = 'Date'
        match = /\Ad:([-0-9]*)\z/.match str_value
        begin
          @value = Date.parse match[1]
        rescue Exception=>e
          raise HaystackRuby::Error, "invalid HaystackRuby::Types::Date #{str_value}.  Error #{e}"
        end
      end
    end
  end
end