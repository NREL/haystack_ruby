module ProjectHaystack
  require 'json'
  require 'pp'
  # may consider making this a mixin instead
  class Project
    
    attr_accessor :name, :haystack_version, :base_url #required
    def initialize(name, config)
      @name = name
      @credentials = config['credentials']
      @base_url = config['base_url']
      @haystack_version = config['haystack_version']
    end
    # for now, setting up to have a single connection per project 
    def connection
      url = "https://#{@base_url}"
      @connection ||= Faraday.new(:url => url) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        faraday.headers['Authorization'] = "Basic #{@credentials}"
        faraday.headers['Accept'] = 'application/json' #TODO enable more formats
      end
    end

    def read(params)
      body = ["ver:\"#{@haystack_version}\""]
      body << params.keys.join(',')
      body << params.values.join(',')
      res = self.connection.post('read') do |req|
        req.headers['Content-Type'] = 'text/plain'
        req.body = body.join("\n")
      end
      JSON.parse! res.body
    end

    def ops
      JSON.parse!(self.connection.get("ops").body)['rows']
    end

    def valid?
      !(@name.nil? || @haystack_version.nil? || @base_url.nil?)
    end
  end
end