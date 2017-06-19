require 'haystack_ruby/types/bin'
require 'haystack_ruby/types/coord'
require 'haystack_ruby/types/date'
require 'haystack_ruby/types/date_time'
require 'haystack_ruby/types/marker'
require 'haystack_ruby/types/n_a'
require 'haystack_ruby/types/number'
require 'haystack_ruby/types/ref'
require 'haystack_ruby/types/str'
require 'haystack_ruby/types/time'
require 'haystack_ruby/types/uri'

module HaystackRuby
  class Object
    # Always present
    attr_reader :value, :haystack_type
    # May be present, depending on type
    attr_reader :unit, :description
    # initialize with a encoded json string
    def initialize val
      case val
        when Array
          @haystack_type = "Array" #may want to decode array components?
          @value = val
        when TrueClass
          @haystack_type = "Boolean"
          @value = val
        when FalseClass
          @haystack_type = "Boolean"
          @value = val
        when NilClass
          @haystack_type = 'Null'
          @value = val
        when String
          # Map to Haystack type per http://project-haystack.org/doc/Json
          case val
            when /\Am:.*/
              include HaystackRuby::Types::Marker
            when /\Az:.*/
              include HaystackRuby::Types::NA
            when /\An:.*/
              extend HaystackRuby::Types::Number
            when /\Ar:.*/
              include HaystackRuby::Types::Ref
            when /\As:.*/
              include HaystackRuby::Types::Str
            when /\Ad:.*/
              include HaystackRuby::Types::Date
            when /\Ah:.*/
              include HaystackRuby::Types::Time
            when /\At:.*/
              include HaystackRuby::Types::DateTime
            when /\Au:.*/
              include HaystackRuby::Types::Uri
            when /\Ab:.*/
              include HaystackRuby::Types::Bin
            when /\Ac:.*/
              include HaystackRuby::Types::Coord
            when /\Ax:.*/
              raise HaystackRuby::Error, "parsing of XStr type is not supported for string val #{val}"
            else
              raise HaystackRuby::Error, "unrecognized type for string val #{val}"
          end
        else
          raise HaystackRuby::Error, "unrecognized type for val #{val}"
        end
      set_fields val
    end
  end
end