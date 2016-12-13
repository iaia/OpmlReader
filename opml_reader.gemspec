# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opml_reader/version'

Gem::Specification.new do |spec|
    spec.name          = "opml_reader"
    spec.version       = OpmlReader::VERSION
    spec.authors       = ["iaia"]
    spec.email         = ["iaia72160@gmail.com"]

    spec.summary       = %q{Opml Reader}
    spec.description   = %q{Opml Reader}
    spec.homepage      = ""

    spec.license       = "MIT"
    spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    spec.bindir        = "exe"
    spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.require_paths = ["lib"]


    spec.files         = `git ls-files -z`.split("\x0").reject do |f|
        f.match(%r{^(test|spec|features)/})
    end
    spec.bindir        = "exe"
    spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.require_paths = ["lib"]

    spec.add_development_dependency "bundler", "~> 1.13"
    spec.add_development_dependency "rake", "~> 10.0"
    spec.add_development_dependency "rspec", "~> 3.0"
    spec.add_dependency "oga"
end
