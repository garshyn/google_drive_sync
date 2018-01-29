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
      @worksheet = @spreadsheet.worksheet_by_title(@title) if @title
    end

    def exists?
      @worksheet.present?
    end

    def create
      @title ||= "New Worksheet"
      @worksheet = @spreadsheet.add_worksheet(@title)
    end

    def clear
      @worksheet.delete if @worksheet
      create
      reset_index
    end

    def reset_index
      @index = 1
    end

    def add_row(row)
      update_cells(@index, 1, [row])
      @index += 1
    end

    def download_to(file)
      puts 'Downloading...'
      result = to_csv file
      puts "Saved to #{file}" if result
    end

    def update_cells(row, col, data)
      @worksheet.update_cells(row, col, data)
    end

    def save
      @worksheet.save
    end

    def to_csv(file)
      if @worksheet.nil?
        puts "ERROR: Worksheet not found"
        return false
      end
      @worksheet.export_as_file(file)
    end

    def all
      @spreadsheet.worksheets.each do |w|
        puts "#{w.gid}: #{w.title}"
      end
    end
  end
end
