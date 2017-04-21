require "google_drive_sync/railtie" if defined?(Rails)
require "google_drive_sync/google"
require "google_drive_sync/task"

module GoogleDriveSync
  def self.default_key
    Rails.application.secrets[:settings_spreadsheet_key]
  end

  def self.default_url
    "https://docs.google.com/spreadsheets/d/#{default_key}/edit"
  end
end
