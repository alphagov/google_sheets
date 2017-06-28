$LOAD_PATH.unshift("../lib")

require 'bundler/setup'
Bundler.setup

require 'rspec'
require 'google_sheets'
require 'webmock/rspec'
require 'vcr'
