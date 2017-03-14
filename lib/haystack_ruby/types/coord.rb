module HaystackRuby
  module Types
    module Coord
      def set_fields str_value
        @haystack_type = 'Coord'
        match = /\Ac:([0-9.-]*),([0-9.-]*)\z/.match str_value
        begin
          @value = [match[1].to_f, match[2].to_f] #value is array of [lat, lng]
        rescue Exception=>e
          raise "invalid HaystackRuby::Types::Coord #{str_value}.  Error #{e}"
        end
      end
    end
  end
end