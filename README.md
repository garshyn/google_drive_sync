# google_drive_sync
Used for syncing translations and seeds in Rails projects.

Based on `google_drive` gem.

Requires `google_config.json` file in the root folder. It will be generated on the first call.
Supports service account configuration which should be returned by `google_config_file` method.

## Tasks

1. Url

`rake google:url`

Print custom or base url

2. Open

`rake google:open`

Open custom or base spreadsheet in browser

3. Describe

`rake google:describe`

Show worksheets titles from both base and custom spreadsheets

4. Download

`rake google:download[title,spreadsheet_key]`

Requires `title` of a worksheet

Downloads a worksheet to a temporary file
