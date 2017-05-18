# google_drive_sync
Used for syncing translations and seeds in Rails projects.

Based on `google_drive` gem.

Requires `google_config.json` file in the root folder. It will be generated on the first call.

## Tasks

1. Download

`rake gds:download[spreadsheet_key,worksheet_title]`

Requires `spreadsheet_key` and `worksheet_title`

Downloads a worksheet to temporary file

2. Seed

`rake gds:seed[spreadsheet_key,worksheet_title]`

Requires `spreadsheet_key` and `worksheet_title`

Downloads a worksheet to temporary file. Creates or updates records in Settings table

3. Url

`rake gds:url`

Print default url

4. Open

`rake gds:open`

Open default Google Spreadsheet in browser
