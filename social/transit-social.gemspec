# # -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "transit-social"

Gem::Specification.new do |s|
  s.name        = "transit-social"
  s.version     = Transit::Social::VERSION
  s.authors     = ["Brent Kirby"]
  s.email       = ["brent@kurbmedia.com"]
  s.homepage    = "https://github.com/kurbmedia/transit"
  s.summary     = %q{Social sharing and commenting functionality for the Transit content engine}
  s.description = %q{Transit-Social adds functionality for commenting and integration with social media networks.}

  s.rubyforge_project = "transit-social"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('transit', '>= 0.0.2')
  s.add_dependency('rails', ">= 3.1")
  
end
