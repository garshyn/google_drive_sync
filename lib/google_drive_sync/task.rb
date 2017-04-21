module GoogleDriveSync
  class Task
    def initialize(spreadsheet_key, worksheet_title)
      @key = spreadsheet_key
      @title = worksheet_title
    end

    def download(file)
      puts 'Downloading...'
      worksheet = GoogleDriveSync::Google.new("google_config.json", @key, @title)
      worksheet.to_csv file
      puts "Written to #{file}"
    end
  end
end
