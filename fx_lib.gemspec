# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fx_lib/version'

Gem::Specification.new do |spec|
  spec.name          = "fx_lib"
  spec.version       = FxLib::VERSION
  spec.authors       = ["hsu"]
  spec.email         = ["hmhlaing@hotmail.com"]
  spec.description   = %q{Fetch foreign exchange rates}
  spec.summary       = %q{Fetch FX rates and store them in database}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
