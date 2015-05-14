Gem::Specification.new do |s|
  s.name = 'project_haystack'
  s.version = '0.0.0'
  s.date = '2015-05-07'
  s.summary = 'Project Haystack Adapter'
  s.description = 'Ruby adapter for Project Haystack REST API'
  s.authors = ['Anya Petersen']
  s.email = 'apeterse@nrel.gov'
  s.files = Dir.glob("lib/**/*")
  s.homepage = 'https://placeholder'
  s.license = 'GNU AFFERO GENERAL PUBLIC LICENSE'
  s.add_development_dependency 'faraday','~> 0.9.1'
  
end