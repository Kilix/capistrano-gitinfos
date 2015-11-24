# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/gitinfos/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-gitinfos"
  spec.version       = Capistrano::Gitinfos::VERSION
  spec.authors       = ["Charles Sanquer"]
  spec.email         = ["csanquer@kilix.fr"]

  spec.summary       = "Fetch git commit informations when deploying with Capistrano 3."
  spec.description   = "Fetch extra git commit informations and storing in a INI/JSON/XML/YML file when deploying with Capstrano 3."
  spec.homepage      = "http://kilix.fr/"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", ">= 3.1"
  spec.add_dependency "sshkit", ">= 1.2.0"
  spec.add_dependency "inifile", ">= 3.0.0"
  spec.add_dependency "json", ">= 1.8.0"
  spec.add_dependency "nokogiri", ">= 1.6.0"
  spec.add_dependency "activesupport", ">= 4.2.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
