# from haystack docs:
# 
# Ranges are exclusive of start timestamp and inclusive of end timestamp. The {date} and {dateTime} options must be correctly Zinc encoded. DateTime based ranges must be in the same timezone of the entity (timezone conversion is explicitly disallowed). Date based ranges are always inferred to be from midnight of starting date to midnight of the day after ending date using the timezone of the his entity being queried.
# ----------------


module HaystackRuby
  class Range
    def initialize(range,time_zone)
      @haystack_time_zone = time_zone
      @finish = nil
      if range.kind_of? Array 
        raise ArgumentError, 'Too many values for range' if range.count > 2
        @start = Timestamp.convert_to_string(range.first, time_zone) 
        if range.count > 1
          @finish = Timestamp.convert_to_string(range.last, time_zone)
          raise ArgumentError, 'Start must be before End' if DateTime.parse(@start) >= DateTime.parse(@finish)
        end
      else
        @start = Timestamp.convert_to_string(range, time_zone)
      end
    end

    def to_s
      if @finish
        "#{@start},#{@finish}"
      elsif @start
        "#{@start}"
      else
        ''
      end
    end
  end
end