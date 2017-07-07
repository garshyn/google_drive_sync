namespace :gds do
  desc "Download a worksheet as csv"
  task :download, [:title, :spreadsheet_key, :worksheet_gid] => [:environment] do |t, args|
    key = args[:spreadsheet_key]
    gid = args[:worksheet_gid]
    title = args[:title] || "title"
    file = "tmp/#{title}.csv"
    GoogleDriveSync::Worksheet.new(key, gid: gid).download_to(file)
  end
end
