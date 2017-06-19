require 'faraday'
require 'haystack_ruby/auth/conversation'
require 'haystack_ruby/config'
require 'haystack_ruby/error'
require 'haystack_ruby/object'
require 'haystack_ruby/point'
require 'haystack_ruby/project'
require 'haystack_ruby/range'
require 'haystack_ruby/timestamp'

require 'active_support/core_ext/hash'
if defined?(Rails)
  require "haystack_ruby/railtie"
end