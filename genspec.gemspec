# -*- encoding: utf-8 -*-

require File.expand_path("lib/genspec/version", File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name = 'genspec'
  s.version = GenSpec::VERSION

  s.authors = ["Colin MacKenzie IV"]
  s.date = '2010-07-08'
  s.description = %q{Simple, expressive Thor and/or Rails 3 generator testing for RSpec. For the Rails 2.3 version, use genspec 0.1.x.}
  s.email = 'sinisterchipmunk@gmail.com'
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = `git ls-files`.split(/\n/)
  s.homepage = %q{http://www.thoughtsincomputation.com}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Simple, expressive Thor and/or Rails 3 generator testing for RSpec. For the Rails 2.3 version, use genspec 0.1.x.}
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'thor'
  s.add_dependency 'rspec', '>= 2'
  s.add_dependency 'sc-core-ext', "~> 1.2.1"

  s.add_development_dependency 'coveralls'
end

