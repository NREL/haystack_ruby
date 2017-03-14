require 'project_haystack/types/bin'
require 'project_haystack/types/coord'
require 'project_haystack/types/date'
require 'project_haystack/types/date_time'
require 'project_haystack/types/marker'
require 'project_haystack/types/n_a'
require 'project_haystack/types/number'
require 'project_haystack/types/ref'
require 'project_haystack/types/str'
require 'project_haystack/types/time'
require 'project_haystack/types/uri'
require 'project_haystack/types/x_str'

module ProjectHaystack
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
        when TrueClass #may come through as string
          @haystack_type = "Boolean"
          @value = val
        when FalseClass #may come through as string
          @haystack_type = "Boolean"
          @value = val
        when NilClass #may come through as string..?
          @haystack_type = 'Null'
          @value = val
        when String
          # Map to Haystack type per http://project-haystack.org/doc/Json
          case val
            when /\Am:.*/
              include ProjectHaystack::Types::Marker
            when /\Az:.*/
              include ProjectHaystack::Types::NA
            when /\An:.*/
              extend ProjectHaystack::Types::Number
            when /\Ar:.*/
              include ProjectHaystack::Types::Ref
            when /\As:.*/
              include ProjectHaystack::Types::Str
            when /\Ad:.*/
              include ProjectHaystack::Types::Date
            when /\Ah:.*/
              include ProjectHaystack::Types::Time
            when /\At:.*/
              include ProjectHaystack::Types::DateTime
            when /\Au:.*/
              include ProjectHaystack::Types::Uri
            when /\Ab:.*/
              include ProjectHaystack::Types::Bin
            when /\Ac:.*/
              include ProjectHaystack::Types::Coord
            when /\Ax:.*/
              include ProjectHaystack::Types::XStr
            else
              raise "unrecognized type for string val #{val}"
          end
        else
          raise "unrecognized type for val #{val}"
        end
      set_fields val
    end
  end
end