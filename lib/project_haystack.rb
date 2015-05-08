module ProjectHaystack
  require 'faraday'
  # took this from mongoid
  # def configure
  #   block_given? ? yield(Config) : Config
  # end

  # For now, just make it work
  BASE_URL = 'skyspark-ops.nrel.gov'
  PROJECT = 'demo'
  # CREDENTIALS = 'ben:'
  # CREDENTIALS_ENCODED = 'YmVuOg==\n'
  # headers = ['Accept: application/json','Authorization: Basic YmVuOg==\n']
  def ops
    # ops_url = "https://#{CREDENTIALS}@#{BASE_URL}/api/#{PROJECT}/ops"
    # puts "checking ops path at #{ops_url}"
    c = conn
    response = c.get("/api/#{PROJECT}/ops")
  end

  def conn
    url = "https://#{BASE_URL}"
    puts "faraday url #{url}"
    conn = Faraday.new(:url => url) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      faraday.headers['Authorization'] = 'Basic YmVuOg==\n'
      faraday.headers['Accept'] = 'application/json'
    end
  end

end