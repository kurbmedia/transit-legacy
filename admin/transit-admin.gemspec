# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "transit/admin/version"

Gem::Specification.new do |s|
  s.name        = "transit-admin"
  s.version     = Transit::Admin::VERSION
  s.authors     = ["Brent Kirby"]
  s.email       = ["brent@kurbmedia.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "transit-admin"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency('transit', '>= 0.0.2')
  s.add_dependency('kaminari', '0.12.4')
  
end
