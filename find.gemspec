# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "find/version"

Gem::Specification.new do |s|
  s.name        = "find"
  s.version     = Find::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Vladimir Vorobyov"]
  s.email       = ["sparrowpublic@gmail.com"]
  s.homepage    = ""
  s.summary     = "find [DIRECTORY] [OPTS]"
  s.description = "simple console utility"

  s.rubyforge_project = "find"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "rspec"
end
