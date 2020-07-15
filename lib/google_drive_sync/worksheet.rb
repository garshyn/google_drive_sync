module GoogleDriveSync
  class Worksheet
    def initialize(spreadsheet_key, title: 'New Worksheet', gid: nil, session: ::GoogleDriveSync.default_session)
      @title = title
      @gid = gid

      @spreadsheet = Spreadsheet.new(spreadsheet_key, session: session)
      @worksheet = spreadsheet.worksheet_by_gid(gid) if gid
      @worksheet = spreadsheet.worksheet_by_title(title) if title
    end

    def self.find(title, custom_spreadsheet: custom_spreadsheet_key, session:)
      title_for_gid = title.split('.').last
      worksheet_gid = custom_worksheet_gid(title_for_gid)
      spreadsheet_options = worksheet_gid.present? ? { gid: worksheet_gid } : { title: title }
      if custom_spreadsheet
        custom_worksheet = new(custom_spreadsheet, spreadsheet_options.merge(session: session))
        return custom_worksheet if custom_worksheet.exists?
      end

      worksheet_gid = base_worksheet_gid(title_for_gid)
      spreadsheet_options = worksheet_gid.present? ? { gid: worksheet_gid } : { title: title }

      new(base_spreadsheet_key, spreadsheet_options.merge(session: session))
    end

    attr_reader :spreadsheet, :worksheet, :title, :gid

    delegate :save, :update_cells, to: :worksheet

    def exists?
      worksheet.present?
    end

    def clear
      worksheet&.delete
      @worksheet = spreadsheet.add_worksheet(title)
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
