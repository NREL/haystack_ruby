module HaystackRuby
  module Types
    # Since there is no Ruby Hour class, value is a string "hr:minute"
    module Time
      def set_fields str_value
        @haystack_type = 'Time'
        match = /\Ah:([0-9:]*)\z/.match str_value
        begin
          @value = match[1]
        rescue Exception=>e
          raise "invalid HaystackRuby::Types::Time #{str_value}.  Error #{e}"
        end
      end
    end
  end
end