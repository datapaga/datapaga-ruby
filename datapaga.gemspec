
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'datapaga'
  s.version     = '0.0.1'
  s.date        = '2017-09-28'
  s.summary     = "Simple API wrapper for DataPaga."
  s.description = "Simple API wrapper for DataPaga."
  s.authors     = ["Ricardo Mejía "]
  s.email       = 'ricardo@techlatam.la'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = 'http://datapaga.com'
  s.license     = 'MIT'

end