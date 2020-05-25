# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name          = 'jekyll-asciimath'
  s.version       = '1.1.0'
  s.authors       = ['Ribose Inc.']
  s.email         = ['open.source@ribose.com']

  s.summary       = 'AsciiMath plugin for Jekyll'
  s.homepage      = 'https://github.com/riboseinc/jekyll-asciimath/'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|spec|features)/!) }

  s.add_runtime_dependency 'jekyll', '~> 4.0'
  s.add_runtime_dependency 'asciimath', '>= 1.0.9', '< 3'
  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'rubocop', '~> 0.50'

  s.require_paths = ["lib"]
end
