# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hangry/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "hangry"
  gem.version       = Hangry::VERSION
  gem.authors       = ["Ian C. Anderson"]
  gem.email         = ["ian@iancanderson.com"]
  gem.description   = %q{A recipe microformat parser.}
  gem.summary       = %q{Parses microformatted recipe HTML into a plain-old-ruby Recipe object.}
  gem.homepage      = "https://github.com/iancanderson/hangry"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activesupport', '>= 3.0'
  gem.add_dependency 'iso8601', '>= 0.4.0'
  gem.add_dependency 'nokogiri', '>= 1.5'
  gem.add_dependency 'oj'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '>= 3.0'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'faraday'
  gem.add_development_dependency 'rspec-its'
end
