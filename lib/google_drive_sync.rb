require 'google_drive'
require "google_drive_sync/railtie" if defined?(Rails)
require "google_drive_sync/worksheet"
require "google_drive_sync/spreadsheet"

module GoogleDriveSync
  def self.default_session
    GoogleDrive::Session.from_config("google_config.json")
  end
end
