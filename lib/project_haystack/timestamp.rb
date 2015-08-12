module ProjectHaystack
  class Timestamp
    # convert ts to a Project Haystack compliant string.
    # ts is a timestamp, tz is a Haystack timezone string
    # for now assumes application timezone is set correctly
    # TODO add a mapping between Ruby and Haystack timezone strings and use here
    def self.convert_to_string ts, tz
      if ts.kind_of? DateTime
        t = ts.to_s
      elsif ts.kind_of? Integer
        t = Time.at(ts).to_datetime.to_s
      elsif ts.kind_of? Date
        t = ts.to_datetime.to_s
      else 
        raise ArgumentError "param must be one of Date, DateTime, Integer"
      end
      "#{t} #{tz}"
    end
  end
end