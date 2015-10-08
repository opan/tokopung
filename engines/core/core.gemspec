$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mesin/core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mesin_core" # rename engine name with prefix mesin*
  s.version     = Mesin::Core::VERSION
  s.authors     = ["opan"]
  s.email       = ["opan.neutron@gmail.com"]
  s.homepage    = "https://github.com/opan"
  s.summary     = "Core feature of TokoPung"
  s.description = "Core feature of TokoPung"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.4"

  # using 'pg' instead sqlite
  s.add_development_dependency "pg"
end
