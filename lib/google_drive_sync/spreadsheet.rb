module GoogleDriveSync
  class Spreadsheet
    def initialize(spreadsheet_key, session: ::GoogleDriveSync.default_session)
      @key = spreadsheet_key
      @spreadsheet = session.spreadsheet_by_key key
    end

    attr_reader :spreadsheet, :key

    delegate :worksheet_by_gid, :worksheet_by_title, :add_worksheet, :worksheets, to: :spreadsheet

    def to_yaml
      puts 'settings:'
      puts "  spreadsheet_key: #{key}"
      worksheets.each do |w|
        puts "  #{w.title}_gid: #{w.gid}"
      end
    end
  end
end
