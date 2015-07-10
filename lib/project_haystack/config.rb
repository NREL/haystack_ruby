module ProjectHaystack
  module Config
    extend self
    attr_accessor :projects

    def load_configuration conf
      @projects = {}
      conf.each do |name, config|
        puts "name #{name} conf #{config}"
        p = Project.new(name, config)
        @projects[name] = p if p.valid?
      end
      puts "projects #{@projects}"
    end

    # called in railtie
    def load!(path, environment = nil)
      require 'yaml'
      environment ||= Rails.env
      conf = YAML.load(File.new(path).read).with_indifferent_access[environment]
      puts "environment: #{environment}"
      puts "conf #{conf}" 
      load_configuration(conf)
    end
  end
end