# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "transit-active-record"

Gem::Specification.new do |s|
  s.name        = "transit-active-record"
  s.version     = Transit::ActiveRecord::VERSION
  s.authors     = ["Brent Kirby"]
  s.email       = ["brent@kurbmedia.com"]
  s.homepage    = ""
  s.summary     = %q{ActiveRecord ORM adapter for the Transit CMS Engine}
  s.description = %q{ActiveRecord ORM adapter for the Transit CMS Engine}

  s.rubyforge_project = "transit-active-record"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('transit-core', [">= 0.0.2"])

end