module ProjectHaystack
  module Config
    extend self
    attr_accessor :projects

    def load_configuration conf
      @projects = {}
      conf.each do |name, config|
        p = Project.new(name, config)
        @projects[name] = p if p.valid?
      end
    end

    # called in railtie
    def load!(path, environment = nil)
      require 'yaml'
      environment ||= Rails.env
      conf = YAML.load(File.new(path).read).with_indifferent_access[environment]
      load_configuration(conf)
    end
  end
end