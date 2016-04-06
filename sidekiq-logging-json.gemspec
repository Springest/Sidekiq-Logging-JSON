# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidekiq/logging/json/version'

Gem::Specification.new do |spec|
  spec.name          = "sidekiq-logging-json"
  spec.version       = Sidekiq::Logging::Json::VERSION
  spec.authors       = ["Wouter de Vos"]
  spec.email         = ["wouter@springest.com"]
  spec.summary       = %q{Sidekiq JSON log format, e.g. for Logstash.}
  spec.description   = <<-DESC
At Springest, we use Logstash to ship all our logs to Elasticsearch. An Elasticsearch index consists of JSON documents.
To make it possible to make fine grained queries on Sidekiq logs, we needed logging in JSON format.

This gem contains that logger.
DESC
  spec.homepage      = "https://github.com/Springest/Sidekiq-Logging-JSON"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency "rspec", "~> 3"

  spec.add_runtime_dependency "sidekiq", ">= 3"
end
