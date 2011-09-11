# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'transit-mongoid'

Gem::Specification.new do |s|
  
  s.name        = "transit-mongoid"
  s.version     = Transit::Mongoid::VERSION
  s.authors     = ["Brent Kirby"]
  s.email       = ["brent@kurbmedia.com"]
  s.homepage    = ""
  s.summary     = %q{Mongoid ORM adapter for the Transit CMS Engine}
  s.description = %q{Mongoid ORM adapter for the Transit CMS Engine}

  s.rubyforge_project = "transit-mongoid"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency("mongoid-rspec", ["~> 1.4"])
  
  s.add_dependency("mongoid", ["~> 2.2"])
  s.add_dependency("mongo", ["~> 1.3"])
  s.add_dependency("bson_ext", ["~> 1.3"])  
  s.add_dependency('transit-core', [">= 0.0.2"])
  
end
