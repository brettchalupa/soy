# frozen_string_literal: true

require_relative "lib/soy/version"

Gem::Specification.new do |spec|
  spec.name = "soy"
  spec.version = Soy::VERSION
  spec.authors = ["Brett Chalupa"]
  spec.email = ["brettchalupa@gmail.com"]

  spec.summary = "Data-backed static site generator"
  spec.description = "Static site builder with support for data models, helpers, an admin, and more."
  spec.homepage = "https://github.com/brettchalupa/soy"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.5"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) ||
        f.match(
          %r{\A(?:(?:bin|test|spec|features|demo)/|\.(?:git|travis|circleci)|appveyor|Rakefile|Gemfile)}
        )
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "kramdown", "~> 2.3"
  spec.add_dependency "listen", "~> 3.7"
  spec.add_dependency "puma", "~> 5.6.2"
  spec.add_dependency "rack", "~> 2.2"
end
