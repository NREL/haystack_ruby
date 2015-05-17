require 'date'
module ProjectHaystack
  module Point
    # project_name is required where this module is mixed in
    def haystack_project
      ProjectHaystack::Config.projects[@project_name]
    end

    def connection
      haystack_project.connection
    end

    def his_read(range)
      query = ["ver:\"#{Config.haystack_version}\"",'id,range',"#{point_id},\"#{range}\""]
      res = connection.post('hisRead') do |req|
        req.headers['Content-Type'] = 'text/plain'
        req.body = query.join("\n")
      end
      JSON.parse! res.body
    end

    def data(range)
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