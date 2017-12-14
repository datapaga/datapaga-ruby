
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'datapaga'
  s.version     = '0.0.2'
  s.date        = '2017-12-14'
  s.summary     = "Simple API wrapper for DataPaga."
  s.description = "Simple API wrapper for DataPaga."
  s.authors     = ["Ricardo Mejía "]
  s.email       = 'ricardo@techlatam.la'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = 'https://datapaga.com'
  s.license     = 'MIT'

end