# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "google_sheets/version"

Gem::Specification.new do |spec|
  spec.name          = "google_sheets"
  spec.version       = GoogleSheets::VERSION
  spec.authors       = ["GOV.UK Dev"]
  spec.email         = ["govuk-dev@digital.cabinet-office.gov.uk"]

  spec.summary       = 'Simplified access to the Google Sheets API.'
  spec.description   = 'Get data and replace data in Google Sheets.'
  spec.homepage      = "https://github.com/alphagov"
  spec.license       = "MIT"

  spec.files = Dir.glob("lib/**/*")
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3"

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "govuk-lint", "~> 1.2.1"
  spec.add_development_dependency "yard", "~> 0.8"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "vcr", "~> 3.0.3"
  spec.add_development_dependency "webmock", "~> 2.1.0"


  spec.add_runtime_dependency "google-api-client", "~> 0.13.0"
end
