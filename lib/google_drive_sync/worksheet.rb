require "google_drive"

module GoogleDriveSync
  class Worksheet
    def initialize(spreadsheet_key, options = {})
      @key = spreadsheet_key
      @title = options[:title]
      @gid = options[:gid]

      session = GoogleDrive::Session.from_config("google_config.json")

      @spreadsheet = session.spreadsheet_by_key(@key)
      @worksheet = @spreadsheet.worksheet_by_gid(@gid) if @gid
      @worksheet = @spreadsheet.worksheet_by_gid(@title) if @title
      # unless @worksheet
      #   @title = "New Worksheet"
      #   @worksheet = @spreadsheet.add_worksheet(@title)
      # end
    end

    def download_to(file)
      puts 'Downloading...'
      to_csv file
      puts "Written to #{file}"
    end

    def update_cells(row, col, data)
      @worksheet.update_cells(row, col, data)
    end

    def save
      @worksheet.save
    end

    def to_csv(file)
      @worksheet.export_as_file(file)
    end

    def all
      @spreadsheet.worksheets.each do |w|
        puts "#{w.gid}: #{w.title}"
      end
    end
  end
end
