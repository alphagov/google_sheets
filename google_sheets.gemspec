# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "google_sheets/version"

Gem::Specification.new do |spec|
  spec.name          = "google_sheets"
  spec.version       = GoogleSheets::VERSION
  spec.authors       = ["Jos Koetsier"]
  spec.email         = ["george.koetsier@digital.cabinet-office.gov.uk"]

  spec.summary       = %q{Simplified access to the Google Sheets API.}
  spec.description   = %q{Get data and replace data in Google Sheets.}
  spec.homepage      = "https://github.com/alphagov"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         =  Dir.glob("lib/**/*")
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.5", ">= 3.5.0"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
end
