Gem::Specification.new do |s|
  s.name = 'haystack_ruby'
  s.version = '0.0.1'
  s.date = '2017-03-14'
  s.summary = 'Project Haystack Ruby Adapter'
  s.description = 'Ruby adapter for Project Haystack REST API'
  s.authors = ['Anya Petersen']
  s.email = 'apeterse@nrel.gov'
  s.files = Dir.glob("lib/**/*")
  s.homepage = 'https://placeholder'
  s.license = 'GNU AFFERO GENERAL PUBLIC LICENSE'
  s.add_dependency 'faraday'
  s.add_dependency 'activesupport'
  s.add_dependency 'openssl'
  s.add_development_dependency "rspec"
  s.test_files = Dir.glob('spec/**/*')
end