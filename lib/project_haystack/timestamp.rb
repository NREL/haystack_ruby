module ProjectHaystack
  class Timestamp
    # convert ts to a Project Haystack compliant string.
    # ts is a timestamp, tz is a Haystack timezone string
    # for now assumes application timezone is set correctly
    # TODO add a mapping between Ruby and Haystack timezone strings and use here
    def self.convert_to_string ts, tz
      puts 'in convert to string'
      if ts.kind_of? DateTime
        t = ts.to_s
      elsif ts.kind_of? Integer
        t = DateTime.at(ts).to_s
      elsif ts.kind_of? Date
        t = ts.to_datetime.to_s
      else 
        raise ArgumentError "param must be one of Date, DateTime, Integer"
      end
      puts " timezone inputs #{ts}, #{tz}"
      "#{t} #{tz}"
    end
  end
end