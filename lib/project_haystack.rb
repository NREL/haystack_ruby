# module ProjectHaystack
#   require 'faraday'
#   # took this from mongoid
#   # def configure
#   #   block_given? ? yield(Config) : Config
#   # end
#   # # For now, just make it work
#   # BASE_URL = 'skyspark-ops.nrel.gov'

#   # headers = ['Accept: application/json','Authorization: Basic YmVuOg==\n']
#   # def ops

#   #   # ops_url = "https://#{CREDENTIALS}@#{BASE_URL}/api/#{PROJECT}/ops"
#   #   # puts "checking ops path at #{ops_url}"
#   #   c = Config.connection('demo')
#   #   response = c.get("/ops")
#   # end

  

# end
require 'faraday'
require 'project_haystack/config'
require 'project_haystack/point'