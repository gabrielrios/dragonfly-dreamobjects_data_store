# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dragonfly/dreamobjects_data_store/version'

Gem::Specification.new do |spec|
  spec.name        = "dragonfly-dreamobjects_data_store"
  spec.version     = Dragonfly::DreamobjectsDataStore::VERSION
  spec.authors     = ["Gabriel Rios"]
  spec.email       = ["gabrielfalcaorios@gmail.com"]
  spec.description = %q{Dreamobjects data store for Dragonfly}
  spec.summary     = %q{Data store for storing Dragonfly content (e.g. images) on Dreamobjects}
  spec.homepage    = "https://github.com/gabrielrios/dragonfly-dreamobjects_data_store"
  spec.license     = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables    = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{ˆ(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "dragonfly", "~> 1.0"
  spec.add_runtime_dependency "aws-sdk", "1.59.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
