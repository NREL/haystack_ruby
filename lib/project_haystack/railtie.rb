require 'rails'
module Rails
  module ProjectHaystack
    class Railtie < Rails::Railtie
        initializer "project_haystack.load-config" do
        config_file = Rails.root.join("config", "project_haystack.yml")
        if config_file.file?
          begin
            ::ProjectHaystack::Config.load!(config_file)
          rescue Exception => e
            # TODO better error handling
            puts "Error loading config for project_haystack: #{e}"
          end
        end
      end
    end
  end
end