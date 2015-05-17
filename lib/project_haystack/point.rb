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
      query = ["ver:\"#{Config.haystack_version}\"",'id,range',"#{point_id},#{range}"]
      res = connection.post('hisRead') do |req|
        req.headers['Content-Type'] = 'text/plain'
        req.body = query.join("\n")
      end
      JSON.parse! res.body
    end
  end
end