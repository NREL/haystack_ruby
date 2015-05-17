require 'date'
module ProjectHaystack
  module Point
    # haystack_project_name is required where this module is mixed in
    def haystack_project
      ProjectHaystack::Config.projects[@haystack_project_name]
    end

    def connection
      haystack_project.connection
    end

    def his_read(range)
      query = ["ver:\"#{Config.haystack_version}\"",'id,range',"#{haystack_point_id},\"#{range}\""]
      pp query.join "\n"
      res = connection.post('hisRead') do |req|
        req.headers['Content-Type'] = 'text/plain'
        req.body = query.join("\n")
      end
      JSON.parse! res.body
    end

    def meta
      # TODO set / refresh haystack_time_zone from the tx in returned data
      # read request on project to load current info, including tags and timezone
      res = haystack_project.read({:id => haystack_point_id})['rows'].first
    end

    def data(range)
      pp range
      # clean up the range argument before passing through to hisRead
      # ----------------
      # from haystack docs:
      # 
      # Ranges are exclusive of start timestamp and inclusive of end timestamp. The {date} and {dateTime} options must be correctly Zinc encoded. DateTime based ranges must be in the same timezone of the entity (timezone conversion is explicitly disallowed). Date based ranges are always inferred to be from midnight of starting date to midnight of the day after ending date using the timezone of the his entity being queried.
      # ----------------
      if range.kind_of? Array 
        range.map! do |r|
          # order of type check matters here as a DateTime is a type of both Date and DateTime
          if r.kind_of? DateTime
            # TODO check that datetime passed in actually matches the haystack time zone of the point.
            "#{r.to_s} #{haystack_time_zone}" if r.kind_of? DateTime
          elsif r.kind_of? Date
            r.to_s
          else
            r 
          end
        end
      end
  
      res = his_read range
      reformat_timeseries(res['rows'])
    end

    # map from 
    def reformat_timeseries data
      data.map do |d|
        # may not keep unit
        {:time => DateTime.parse(d['ts']).to_time.to_i, :value => d['val'], :unit => ['val.unit']}
      end
    end
  end
end