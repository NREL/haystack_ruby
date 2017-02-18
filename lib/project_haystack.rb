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
require 'project_haystack/project'
require 'project_haystack/range'
require 'project_haystack/timestamp'
require 'project_haystack/auth/conversation'
# require 'project_haystack/auth/scram'
require 'active_support/core_ext/hash'
if defined?(Rails)
  require "project_haystack/railtie"
end