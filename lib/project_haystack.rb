require 'faraday'
require 'project_haystack/auth/conversation'
require 'project_haystack/config'
require 'project_haystack/object'
require 'project_haystack/point'
require 'project_haystack/project'
require 'project_haystack/range'
require 'project_haystack/timestamp'

require 'active_support/core_ext/hash'
if defined?(Rails)
  require "project_haystack/railtie"
end