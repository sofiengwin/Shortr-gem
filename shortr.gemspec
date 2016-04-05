# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "shortr/version"

Gem::Specification.new do |spec|
  spec.name          = "shortr"
  spec.version       = Shortr::VERSION
  spec.authors       = ["Ogbara Godwin"]
  spec.email         = ["godwin.onisofien@andela.com"]

  spec.summary       = "Write a short summary, because Rubygems requires one."
  spec.description   = "Write a longer description or delete this line."
  spec.homepage      = "https://github.com/andela-gogbara/Shortr-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["shortr"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "vcr", "~> 2.9", ">= 2.9.3"
  spec.add_development_dependency "webmock", "~> 1.22", ">= 1.22.1"
  spec.add_development_dependency "simplecov", "~> 0.10.0"
  spec.add_development_dependency "coveralls"

  spec.add_dependency "faraday", "~> 0.9", ">= 0.9.2"
  spec.add_dependency "json", "~> 1.8", ">= 1.8.3"
end
