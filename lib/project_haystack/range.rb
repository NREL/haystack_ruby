# from haystack docs:
# 
# Ranges are exclusive of start timestamp and inclusive of end timestamp. The {date} and {dateTime} options must be correctly Zinc encoded. DateTime based ranges must be in the same timezone of the entity (timezone conversion is explicitly disallowed). Date based ranges are always inferred to be from midnight of starting date to midnight of the day after ending date using the timezone of the his entity being queried.
# ----------------


module ProjectHaystack
  class Range
    def initialize(range,time_zone)
      throw 'invalid range' if range.kind_of? Array and range.size > 2
      @haystack_time_zone = time_zone
      @start = (range.kind_of? Array) ? format(range.first) : format(range)
      @finish = (range.kind_of? Array) ? format(range.last) : nil
    end
    
    def format(dt)
      if dt.kind_of? DateTime
        # TODO check that datetime passed in actually matches the haystack time zone of the point.
        "#{dt.to_s} #{@haystack_time_zone}" 
      elsif dt.kind_of? Date
        dt.to_s
      else
        dt 
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