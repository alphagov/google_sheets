require_relative './google_sheets/version'
require 'google/apis/sheets_v4'
require 'csv'

class GoogleSheets

  Sheets = Google::Apis::SheetsV4
  SCOPES = %w[https://www.googleapis.com/auth/drive.file
              https://www.googleapis.com/auth/drive
              https://www.googleapis.com/auth/spreadsheets].freeze
  TOKEN_CREDENTIAL_URI = 'https://www.googleapis.com/oauth2/v3/token'.freeze
  AUDIENCE = 'https://www.googleapis.com/oauth2/v3/token'.freeze
  VALUE_INPUT_OPTION = 'USER_ENTERED'.freeze

  def initialize(key_file:, sheet_name: 'Sheet1')
    key_file_hash = JSON.parse(key_file.read, symbolize_names: true)

    @sheet_name = sheet_name
    @sheet_service = Sheets::SheetsService.new
    @sheet_service.authorization = Signet::OAuth2::Client.new(token_credential_uri: TOKEN_CREDENTIAL_URI,
                                                              audience: AUDIENCE,
                                                              scope: SCOPES,
                                                              issuer: key_file_hash[:client_email],
                                                              signing_key: OpenSSL::PKey::RSA.new(key_file_hash[:private_key]))
  end

  def replace_document(sheet_id:, data: [[]], range: nil)
    @sheet_service.clear_values(sheet_id, range || @sheet_name)
    @sheet_service.update_spreadsheet_value(sheet_id,
                                            range || @sheet_name,
                                            Sheets::ValueRange.new(values: data),
                                            value_input_option: VALUE_INPUT_OPTION)
  end

  def get_document(sheet_id:, range: nil)
    @sheet_service.get_spreadsheet_values(sheet_id, range || @sheet_name)
  end

end
