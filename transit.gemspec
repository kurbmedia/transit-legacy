# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'transit/version'

Gem::Specification.new do |s|
  
  s.name        = "transit"
  s.version     = Transit::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brent Kirby / kurb media llc"]
  s.email       = ["dev@kurbmedia.com"]
  s.homepage    = "https://github.com/kurbmedia/transit"
  s.summary     = %q{Transit is a Rails 3.1+ content management engine}
  s.description = %q{Transit is a content management and delivery engine designed for use with Rails 3.1+}

  s.rubyforge_project = "transit"

  s.files         = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  
  s.add_dependency("transit-core", ["= 0.0.2"])
    
end
