require 'google_drive'

module GoogleDriveSync
  class Spreadsheet
    def initialize(spreadsheet_key, options = {})
      session = GoogleDrive::Session.from_config("google_config.json")

      @key = spreadsheet_key
      @spreadsheet = session.spreadsheet_by_key @key
    end

    def to_yaml
      puts "  settings:"
      puts "    spreadsheet_key: #{@key}"
      @spreadsheet.worksheets.each do |w|
        puts "    #{w.title}_gid: #{w.gid}"
      end
    end
  end
end
