# from haystack docs:
# 
# Ranges are exclusive of start timestamp and inclusive of end timestamp. The {date} and {dateTime} options must be correctly Zinc encoded. DateTime based ranges must be in the same timezone of the entity (timezone conversion is explicitly disallowed). Date based ranges are always inferred to be from midnight of starting date to midnight of the day after ending date using the timezone of the his entity being queried.
# ----------------


module ProjectHaystack
  class Range
    def initialize(range,time_zone)
      @haystack_time_zone = time_zone
      @finish = nil
      if range.kind_of? Array 
        raise ArgumentError, 'Too many values for range' if range.count > 2
        @start = format(range.first) 
        if range.count > 1
          @finish = format(range.last)
          raise ArgumentError, 'Start must be before End' if DateTime.parse(@start) >= DateTime.parse(@finish)
        end
      else
        @start = format(range)
      end
    end
    
    def format(dt)
      if dt.kind_of? DateTime
        # TODO check that datetime passed in actually matches the haystack time zone of the point.
        "#{dt.to_s} #{@haystack_time_zone}" 
      elsif dt.kind_of? Date
        dt.to_s
      else
        raise ArgumentError, 'Start and end must be Date or DateTime'
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