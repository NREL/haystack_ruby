module ProjectHaystack
  class Object
    # Always present
    attr_reader :value, :haystack_type
    # May be present, depending on type
    attr_reader :unit, :description
    # initialize with a encoded json string
    def initialize val
      case val.class
        when Array
          @haystack_type = "Array" #may want to decode array components?
          @value = val
        when Boolean #may come through as string
          @haystack_type = "Boolean"
          @value = val
        when NilClass #may come through as string..?
          @haystack_type = 'Null'
          @value = val
        when String
          # Map to Haystack type per http://project-haystack.org/doc/Json
          case val
            when /\Am:.*/
              include Types::Marker
            when /\Az:.*/
              include Types::NA
            when /\An:.*/
              include Types::Number
            when /\Ar:.*/
              include Types::Ref
            when /\As:.*/
              include Types::Str
            when /\Ad:.*/
              include Types::Date
            when /\Ah:.*/
              include Types::Time
            when /\At:.*/
              include Types::DateTime
            when /\Au:.*/
              include Types::Uri
            when /\Ab:.*/
              include Types::Bin
            when /\Ac:.*/
              include Types::Coord
            when /\Ax:.*/
              include Types::XStr
            else
              raise "unrecognized type for val #{val}"
          end
        else
          raise "unrecognized type for val #{val}"
        end
      set_fields val
    end
  end
end