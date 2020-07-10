module GoogleDriveSync
  class Worksheet
    def initialize(spreadsheet_key, title: 'New Worksheet', gid: nil, session: ::GoogleDriveSync.default_session)
      @title = title

      @spreadsheet = Spreadsheet.new(spreadsheet_key, session: session)
      @worksheet = spreadsheet.worksheet_by_gid(gid) if gid
      @worksheet = spreadsheet.worksheet_by_title(title) if title
    end

    attr_reader :spreadsheet, :worksheet, :title
    delegate :save, :update_cells, to: :worksheet

    def exists?
      worksheet.present?
    end

    def create
      @worksheet = spreadsheet.add_worksheet(title)
    end

    def clear
      worksheet.delete if worksheet
      create
      reset_index
    end

    def download_to(file)
      puts 'Downloading...'
      result = to_csv file
      puts "Saved to #{file}" if result
    end

    def to_csv(file)
      if worksheet.nil?
        puts "ERROR: #{gid} #{@title} Worksheet not found"
        return false
      end
      worksheet.export_as_file(file)
    end

    def all
      spreadsheet.to_yaml
    end
  end
end
