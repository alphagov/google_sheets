require_relative './spec_helper'

include WebMock::API

describe GoogleSheets do
  before :all do
    VCR.configure do |config|
      config.cassette_library_dir = File.expand_path("../fixtures/vcr_cassettes", __FILE__)
      config.hook_into :webmock
    end
  end

  context 'valid key' do
    before :each do
      valid_key = {
        "type" => "service_account",
        "project_id" => "taxon-170814",
        "private_key_id" => "3f689af153141693bfe652212375382e0d04be6d",
        "private_key" => "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC1Gq/MKu3NAWZx\ng3yIUDWzK5iIrUgvBMgtXK5hhqHT9rdTN2QbbB4y/Qkj/piMxWsgWyAvAJuN/b/V\npECEeh03pUYg0LVzwIg9lEA+a52fQoZx3qoR/lYCTK25G9riFaj3/1TDSiH7X1Sr\n1F3RlaqJB0aSbBMq0WchQ8FsEljRfB7YS8WIJt9x0T5xCjuRAodmWqcgjOCkyYvO\nBoWazreKG9CDYtUGkQzehILRq5eQVRotGG/a6S++QkvowegNvLP4F5An7+XOZt0U\nTuNlyeNQmYQDuZvs330+0U21Yoni84p8d0oTFIp/NZHUFvm6tfdkx3fD8fd6KggI\nL5z7vky7AgMBAAECggEAVqEmWH5sc/TogQIJbtcXaNZAx5hEACHEc1ZzH7mb7V2F\nweusGiX0qCU72xjs9eF1ZevREEq1Hg20VsiUCAq1sSmAyy+qrGz7fqFMvc8Sfdz/\nnLaLGcJUeBMfwn0djaoYwlBDxorOiITIZs1V92wlQBjX3DCQVpoGP/Y+Lqj0DXgI\n4VydjbgM0agYB7Q8HhQ43Xbi4CwPmGm9UY6FOgLNTS424NvCH9kI21K28Dw/DLFc\nULjUeTE/1iJbvF5fiy7aEZhYBwzGNmvJGUkdKwqsOoGYsh4hImHwnYYR5KIPPPUj\nfRPDhNH109ohisiNBgo6Cs6Y9V+zfIlWvPRoXDyxCQKBgQDdd4KDVFTJ02mAkTli\nSPH3H/3ODxI9uc+z0xGsgrezs1FdrZ3xFdiyqgbPApNM4QWP0UqqlFejgwN6i8bb\nG7KtckLQ1ADr3jw4l9mb7oCP0mZl46CroLxv7sXTFAMgfV9RVjzOVFrF47atvmf1\nPWDnl/idvsTSNI8jysRCshdkHQKBgQDRV/y45PasJ9Vwm6alzLZo8weEau5tBH4M\nHl24H4M/D1hgHAiQMRN7CcLb9D25EzY3nEx3bYHFRMo9PXEy578hwM/G/AbYAZwE\nTpQ9zd1zCYou7Ond9dQX/XzjB1GtZWFDUHxxyz2MNrF8LfgOlhTus9KV4dxRgYFJ\n21nh/LfstwKBgQC5KrIRshHOSZf9ae7LsWe1kqb3gXxj5Za2qHQvg3+qnPQb2gyj\nRPvQrf5RWLrl3YJz8651HuCDkwf2jyWtjuP+xvj8dzVqAH7jZnsIOAp/tY/uArsU\npKjJAZ+fUy0mHgzzCaJ/dOIMcM8NR5TN5ArAuDyjT5xqkI1ZhLBBf3u1NQKBgCZr\nu5pDi3I1LVspdgBf/eptECghZ/jiJjAbMqAkSHY+Xr3k5z1vhF/EftrXjKx29jBm\nozIYCwUlhuiOakQpfE65kGi4wJjMUtIHifV93vLKAW5zVMjD4VU11MHmCfuE68Dq\n+Kv53SXqs9BSr4Ad02Gr5y5S8ZiT6CKh+3EabLcpAoGBAM2jDqN9rNE0Js4lCVAt\ng1YzoBASPA+r5L/dro7djGBJIquN4y3fcFhYVGjg0U69j88OydYPcICk4DFeP9gp\n2vHHSgD+SsvbSu/CVKIyIAjfDOKthX2ea9cJuj6oOnPs+k8f9qZ+OZUy3xVxCb2t\nJ1naHFoZlv43Oy1QaNFJDHu3\n-----END PRIVATE KEY-----\n",
        "client_email" => "taxon-sheet@taxon-170814.iam.gserviceaccount.com",
        "client_id" => "116781012552260850169",
        "auth_uri" => "https://accounts.google.com/o/oauth2/auth",
        "token_uri" => "https://accounts.google.com/o/oauth2/token",
        "auth_provider_x509_cert_url" => "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url" => "https://www.googleapis.com/robot/v1/metadata/x509/taxon-sheet%40taxon-170814.iam.gserviceaccount.com"
      }

      @google_sheets = GoogleSheets.new(key_file: StringIO.new(valid_key.to_json))
      @data = [%w[Item Price], %w[Grommet 100]].freeze
    end
    it 'gets a spreadsheet' do
      VCR.use_cassette("get_sheet") do
        expect(@google_sheets.get_document(sheet_id: '1InL5J5lzvaWGX8ymzotFKGuLUE5xxPg5l7Db-vRhQvY', range: 'Sheet1').values).to eq(@data)
      end
    end

    it 'replaces a spreadsheet' do
      VCR.use_cassette("put_sheet") do
        expect(@google_sheets.replace_document(sheet_id: '1InL5J5lzvaWGX8ymzotFKGuLUE5xxPg5l7Db-vRhQvY', data: @data).updated_cells).to eq(4)
      end
    end

    it 'replaces a spreadsheet using a range' do
      VCR.use_cassette("put_sheet_partial") do
        expect(@google_sheets.replace_document(sheet_id: '1InL5J5lzvaWGX8ymzotFKGuLUE5xxPg5l7Db-vRhQvY', data: @data, range: 'Sheet1!C1:D2').updated_cells).to eq(4)
      end
    end

    describe 'replacing a spreadsheet with an unknown spreadsheet id' do
      it 'raises an error' do
        VCR.use_cassette("put_sheet_invalid_spreadsheet_id") do
          expect {
            @google_sheets.replace_document(sheet_id: 'unknown_id', data: @data)
          }.to raise_error Google::Apis::ClientError
        end
      end
    end
  end

  context 'an invalid key file' do
    before :each do
      invalid_key = {
        "private_key" => "invalid"
      }
      @invalid_key_file = StringIO.new(invalid_key.to_json)
    end
    it 'raises an error' do
      expect { GoogleSheets.new(key_file: @invalid_key_file) }.to raise_error OpenSSL::PKey::RSAError
    end
  end
end
