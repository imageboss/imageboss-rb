lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imageboss/version'

Gem::Specification.new do |spec|
  spec.name          = 'imageboss-rb'
  spec.version       = ImageBoss::VERSION
  spec.authors       = ['Igor Escobar']
  spec.email         = ['igor@imageboss.me']
  spec.description   = 'Generate ImageBoss URLs with Ruby'
  spec.summary       = 'Official Ruby Gem for generating ImageBoss URLs.'
  spec.homepage      = 'https://github.com/imageboss/imageboss-rb'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.0'
  spec.add_development_dependency "rspec"
end
