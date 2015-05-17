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
      res = connection.post('hisRead') do |req|
        req.headers['Content-Type'] = 'text/plain'
        req.body = query.join("\n")
      end
      JSON.parse! res.body
    end

    def meta
      # read request on project to load current info, including tags and timezone
      res = haystack_project.read({:id => haystack_point_id})['rows'].first
    end

    def data(range)
      # clean up the range argument before passing through to hisRead
      # ----------------
      # from haystack docs:
      # 
      # Ranges are exclusive of start timestamp and inclusive of end timestamp. The {date} and {dateTime} options must be correctly Zinc encoded. DateTime based ranges must be in the same timezone of the entity (timezone conversion is explicitly disallowed). Date based ranges are always inferred to be from midnight of starting date to midnight of the day after ending date using the timezone of the his entity being queried.
      # ----------------
      if range.kind_of? Array 
        range.map! do |r|
          r.to_s if r.kind_of? Date
        end
        range = range.join(',')
      end
      if range.kind_of? Date
        range = range.to_s
      end
      if range.kind_of? DateTime
        # Ex: 2009-11-09T15:39:00Z
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