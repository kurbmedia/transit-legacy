# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "transit/version"

Gem::Specification.new do |s|
  s.name        = "transit"
  s.version     = Transit::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brent Kirby / kurb media llc"]
  s.email       = ["dev@kurbmedia.com"]
  s.homepage    = "https://github.com/kurbmedia/transit"
  s.summary     = %q{Transit is a Rails 3.1+ MongoDB/Mongoid based content management engine}
  s.description = %q{Transit is a content management and delivery engine designed for use with Rails 3.1+ MongoDB and Mongoid}

  s.rubyforge_project = "transit"

  s.files         = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency("mocha", ["= 0.9.12"])
  s.add_development_dependency("capybara", ["= 0.4.0"])  
  s.add_development_dependency("fabrication", ["~> 0.9.5"])
  s.add_development_dependency("ffaker", ["~> 1.7"])
  s.add_development_dependency("mongoid", ["~> 2.0"])
  s.add_development_dependency("mongo", ["~> 1.3"])
  s.add_development_dependency("bson_ext", ["~> 1.3"])

  s.add_dependency("nokogiri", ["~> 1.4"])
  s.add_dependency("motr", [">= 0.0.8"])
  
  
end
