require 'bundler/setup'
require 'yaml'
Bundler.setup
require 'haystack_ruby' # and any other gems you need

# configuration constants used for testing
CONFIG_PATH = 'config/example.yml' #path to the settings file, relative to directory root
CONFIG_ENV = 'test' #environment to load from settings file for testing
PROJECT = 'demov3' #name of project to use for testing.  Must match name in the settings file.
PT_ID = '1d5675a8-867de4b8' #Haystack ID of an existing point that is safe for to use for testing. NOTE that this point will be written to.
PT_PROJ = PROJECT # Optionally use a different project name for the point tests
PT_TZ = 'Denver' # Timezone of your test point


Time.zone='Mountain Time (US & Canada)'
RSpec.configure do |config|
  config.before(:suite) do
    CONF = YAML.load(File.new(CONFIG_PATH).read).with_indifferent_access[CONFIG_ENV]
    HaystackRuby::Config.load_configuration CONF
  end

end