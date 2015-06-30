module ProjectHaystack
  module Config
    extend self
    ENVIRONMENT = ENV['RAILS_ENV'] || 'development'
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
    def haystack_version 
      '2.0'
    end
    # returns array of ProjectHaystack::Projects
    def projects
      require 'yaml'
      if @project_configs.nil? && @projects.nil? 
        @project_configs = YAML.load(File.new(config_file).read)[ENVIRONMENT]
        @projects = {}
        @project_configs.map do |name, config|
          p = Project.new(name, config)
          @projects[name] = p if p.valid?
        end
      end
      @projects
    end
  end
end