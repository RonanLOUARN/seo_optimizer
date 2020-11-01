# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require_relative 'lib/seo_optimizer/version'

Gem::Specification.new do |spec|
  spec.name          = "seo_optimizer"
  spec.version       = SeoOptimizer::VERSION
  spec.authors       = ["Ronan Louarn"]
  spec.email         = ["ronan33720@hotmail.com"]

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.summary       = %q{Simple gem to improve SEO to your rails app.}
  spec.description   = %q{Simple gem to improve SEO to your rails app.}
  spec.homepage      = "https://www.lr-dev.fr"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/RonanLOUARN/seo_optimizer"
  spec.metadata["changelog_uri"] = "https://github.com/RonanLOUARN/seo_optimizer/commits/master"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency 'sitemap_generator'
end
