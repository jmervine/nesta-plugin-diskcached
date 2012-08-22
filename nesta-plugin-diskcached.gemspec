# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nesta-plugin-diskcached/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joshua Mervine"]
  gem.email         = ["joshua@mervine.net"]
  gem.description   = %q{A Nesta plugin for disk cacheing via diskcached.}
  gem.summary       = %q{A Nesta plugin for disk cacheing via diskcached. Also see: http://diskcached.rubyops.net/}
  gem.homepage      = "http://github.com/jmervine/nesta-plugin-diskcached"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nesta-plugin-diskcached"
  gem.require_paths = ["lib"]
  gem.version       = Nesta::Plugin::Diskcached::VERSION
  gem.add_dependency("nesta", ">= 0.9.11")
  gem.add_dependency("diskcached", ">= 1.1.0")
  gem.add_development_dependency("rake")
  gem.add_development_dependency("yard")
end

