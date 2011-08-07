# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "transit-core"

Gem::Specification.new do |s|
  s.name        = "transit-core"
  s.version     = Transit::VERSION
  s.authors     = ["Brent Kirby"]
  s.email       = ["brent@kurbmedia.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "transit-core"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency("mocha", ["= 0.9.12"])
  s.add_development_dependency("capybara", ["= 0.4.0"])  
  s.add_development_dependency("fabrication", ["~> 1.0"])
  s.add_development_dependency("ffaker", ["~> 1.8"])
  s.add_development_dependency("rspec", ["~> 2.6"])  
  s.add_development_dependency("rspec-rails-mocha", ["~> 0.3"])
  
  s.add_dependency("rails", [">= 3.1.0.rc5"])
  s.add_dependency("nokogiri", ["~> 1.5"])
  s.add_dependency("paperclip", ["~> 2.3"])
  s.add_dependency("inherited_resources", ["= 1.2.2"])
  s.add_dependency("responders", ["= 0.6.4"])
  
  
end
