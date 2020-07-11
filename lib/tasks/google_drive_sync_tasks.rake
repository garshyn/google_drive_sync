namespace :google do
  desc 'Print Google Spreadsheet url with settings'
  task url: :environment do
    puts google_url
  end

  desc 'Open Google Spreadsheet with settings in browser'
  task open: :environment do
    `open #{google_url}`
  end

  desc 'Show all worksheets'
  task describe: :environment do
    session = google_session
    GoogleDriveSync::Spreadsheet.new(base_spreadsheet_key, session: session).to_yaml
    puts 'custom:'
    GoogleDriveSync::Spreadsheet.new(custom_spreadsheet_key, session: session).to_yaml
  end

  desc 'Download a worksheet as csv'
  task :download, [:title, :spreadsheet_key] => [:environment] do |_t, args|
    args.with_defaults(title: 'title', spreadsheet_key: custom_spreadsheet_key || base_spreadsheet_key)
    file = "tmp/#{args[:title]}.csv"
    GoogleDriveSync::Worksheet.find(
      args[:title],
      custom_spreadsheet: args[:spreadsheet_key],
      session: google_session,
    ).download_to(file)
  end

  def google_url(spreadsheet: custom_spreadsheet_key || base_spreadsheet_key, gid: nil)
    gid_param = "#gid=#{gid}" if gid
    "https://docs.google.com/spreadsheets/d/#{spreadsheet}/edit#{gid_param}"
  end

  def base_spreadsheet_key
    Rails.application.secrets.settings[:spreadsheet_key]
  end

  def custom_spreadsheet_key
    Rails.application.secrets.settings&.dig(:custom, :spreadsheet_key)
  end

  def base_worksheet_gid(key)
    Rails.application.secrets.settings[:"#{key}_gid"]
  end

  def custom_worksheet_gid(title)
    Rails.application.secrets.settings&.dig(:custom, :"#{title}_gid")
  end

  def google_session
    if File.exist? google_config_file
      GoogleDrive::Session.from_service_account_key(google_config_file)
    else
      GoogleDrive::Session.from_config('google_config.json')
    end
  end
end
