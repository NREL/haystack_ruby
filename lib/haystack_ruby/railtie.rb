require 'rails'
module Rails
  module HaystackRuby
    class Railtie < Rails::Railtie
        initializer "haystack_ruby.load-config" do
        config_file = Rails.root.join("config", "haystack_ruby.yml")
        if config_file.file?
          begin
            ::HaystackRuby::Config.load!(config_file)
          rescue Exception => e
            # TODO better error handling
            puts "Error loading config for haystack_ruby: #{e}"
          end
        end
      end
    end
  end
end