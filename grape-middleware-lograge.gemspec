# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = 'grape-middleware-lograge'
  spec.version       = '1.2.3'
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ['Ryan Buckley', 'Paul Chavard']
  spec.email         = ['arebuckley@gmail.com', 'paul+github@chavard.net']
  spec.summary       = %q{A logger for the Grape framework}
  spec.description   = %q{Logging middleware for the Grape framework, that uses Lograge}
  spec.homepage      = 'https://github.com/tchak/grape-middleware-lograge'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'grape', '>= 0.14'
  spec.add_dependency 'lograge', '~> 0.3'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '>= 3.2', '< 4'
end
