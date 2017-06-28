require 'csv'
require 'rake'
require_relative '../lib/google_sheets'

desc 'replaces a spreadsheet - ENV: CSV_PATH, KEY_PATH, SPREADSHEET_ID, SHEET_NAME'
task :replace_spreadsheet do
  raise "CSV_PATH undefined" if ENV['CSV_PATH'].nil?
  raise "KEY_PATH undefined" if ENV['KEY_PATH'].nil?
  raise "SPREADSHEET_undefined" if ENV['SPREADSHEET_ID'].nil?

  sheet_name = ENV['SHEET_NAME'] || 'Sheet1'
  data = CSV.read(ENV['CSV_PATH'])
  keyfile = File.open(ENV['KEY_PATH'])
  service = GoogleSheets.new(key_file: keyfile, sheet_name: sheet_name)
  result = service.replace_document(sheet_id: ENV['SPREADSHEET_ID'], data: data)
  puts "Updated #{result.updated_cells} cells"
end
