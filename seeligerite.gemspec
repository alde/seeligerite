$:.push File.expand_path("../lib", __FILE__)
require "rake"

Gem::Specification.new do |s|
    s.platform      = Gem::Platform::RUBY
    s.authors       = ['Rickard Dybeck']
    s.email         = ['r.dybeck@gmail.com']
    s.homepage      = "http://alde.nu"
    s.summary       = "Seeligerite is a IO library"
    s.name          = "seeligerite"
    s.version       = "0.0.1"
    s.date          = "2013-05-26"
    s.files         = FileList['lib/**/*.rb']
    s.require_paths = ["lib"]
end
