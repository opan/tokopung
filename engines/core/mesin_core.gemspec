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
  s.add_dependency "haml-rails"
  s.add_dependency "mini_magick"
  s.add_dependency "ckeditor"
  s.add_dependency "carrierwave"
  s.add_dependency "kaminari"
  s.add_dependency 'bcrypt'
  s.add_dependency "twitter-bootstrap-rails"
  s.add_dependency "less-rails"
  s.add_dependency 'jquery-rails'
  s.add_dependency 'therubyracer'
  s.add_dependency 'sass-rails'
  s.add_dependency 'uglifier'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'devise'
  
  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "capybara"
end
