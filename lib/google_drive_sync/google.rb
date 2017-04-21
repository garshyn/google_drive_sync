require "google_drive"

module GoogleDriveSync
  class Google
    def initialize(config, spreadsheet_key, worksheet_title)
      @key = spreadsheet_key
      @title = worksheet_title

      session = GoogleDrive::Session.from_config(config)
      @sheet = session.spreadsheet_by_key(@key).worksheet_by_title(@title)
      @sheet = session.spreadsheet_by_key(@key).add_worksheet(@title) unless @sheet
    end

    def update_cells(row, col, data)
      @sheet.update_cells(row, col, data)
    end

    def save
      @sheet.save
    end

    def to_csv(file)
      @sheet.export_as_file(file)
    end
  end
end
