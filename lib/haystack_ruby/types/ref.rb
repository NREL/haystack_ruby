module HaystackRuby
  module Types
    module Ref
      def set_fields str_value
        @haystack_type = 'Ref'
        match = /\Ar:([^ ]*) (.*)\z/.match str_value
        raise HaystackRuby::Error, HaystackRuby::Error, "invalid HaystackRuby::Types::Ref: #{str_value}" if match.nil?
        @value = match[1] #ref id
        @description = match[2]
      end
    end
  end
end