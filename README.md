This API allows simplified access to Google Sheets.

**To gain access to a spreadsheet in Google Sheets:**

1. Create a new, empty Google spreadsheet and note the Spreadsheet ID, which can be found as part of the URL. 
If the URL is: https://docs.google.com/spreadsheets/d/1UgxVGDt8X0YgB9JYRVQipCqa-nwcnZkKbm0ULOJgEYc/edit#gid=0,  
then the Spreadsheet ID would be: 1UgxVGDt8X0YgB9JYRVQipCqa-nwcnZkKbm0ULOJgEYc.
2. Visit the Google Api Manager at: https://console.cloud.google.com/apis/library.
3. Click Library->Sheets API and if necessary create a new project.
4. Enable the Google Sheets API.
5. Click Credentials -> Create Credentials -> Service Account Key.
6. If necessary, create a new 'service account', with a role: Project->Owner.
7. Create a new JSON key and save this file somewhere.
8. Go back to the Google Spreadsheet and share it with the e-mail address of the service account.
This can be found in the Key File under client_email.

**To initialise:**
```ruby
sheets = GoogleSheets.new(key_file: File.open('keyfile.json'), sheet_name: 'Sheet1')
```

- keyfile: path the JSON key file saved in step 7. 
- sheet_name(optional): The name of the sheet to use. Defaults to 'Sheet1'.

**To get values in a sheet**
```ruby
sheets.get_document(sheet_id: '1UgxVGDt8X0YgB9JYRVQipCqa-nwcnZkKbm0ULOJgEYc', range: 'Sheet1').values
```

- sheet_id: The ID of the spreadsheet (step 1).
- range(optional): The range of values in A1 notation: https://developers.google.com/sheets/api/guides/concepts. 
Defaults to the whole spreadsheet.

**To replace a spreadsheet:**
```ruby
sheets.replace_document(sheet_id: '1UgxVGDt8X0YgB9JYRVQipCqa-nwcnZkKbm0ULOJgEYc', data: [%w[Item Price], %w[Grommet 100], %w[Widget 50]], range: 'Sheet1!B1:C2')
```
- sheet_id: The ID of the spreadsheet (step 1).
- data: A two dimensional array of data to upload to the spreadsheet.
- range(optional) Range to replace in A1 notation.

**Rake Task**

```text
rake replace_spreadsheet SPREADSHEET_ID=1UgxVGDt8X0YgB... KEY_PATH=~/keyfile.json CSV_PATH=~/data.csv
```