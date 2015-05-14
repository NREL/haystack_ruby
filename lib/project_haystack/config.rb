module ProjectHaystack
  module Config
    extend self
    ENVIRONMENT = 'development'
    def config_file
      # TODO use railtie to try loading config/project_haystack.yml
      # and set as @config_file
      # cf = Rails.root.join("config", "project_haystack.yml")
      # if cf.file?
      #   File.new(cf)
      # else
        # TODO make this configurable
       '/Users/apeterse/projects/project_haystack/config/example.yml'
      # end
    end
    # TODO run this on init as load! method
    def projects
      require 'yaml'
      @projects ||= YAML.load(File.new(config_file).read)[ENVIRONMENT]
    end
    # should be singleton
    def connection(project_name)
      project = projects[project_name]
      throw "unrecognized project #{project_name}" if project.nil?
      url = "https://#{project['base_url']}"
      puts "faraday url #{url}"
      conn ||= Faraday.new(:url => url) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        faraday.headers['Authorization'] = "Basic #{project['credentials']}"
        faraday.headers['Accept'] = 'application/json'
    end
  end
  end
end