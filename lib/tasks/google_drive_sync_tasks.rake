require 'csv'
# require 'launchy'

namespace :gds do
  desc "Seed or update settings"
  task :download, [:spreadsheet_key, :worksheet_title] => [:environment] do |t, args|
    key = args[:spreadsheet_key] || GoogleDriveSync.default_key
    title = args[:worksheet_title] || 'Settings'
    # delete_file = false
    file = "tmp/#{title}-#{Time.now.strftime('%y%m%d-%H%M%S')}.csv"
    GoogleDriveSync::Task.new(key, title).download(file)

    # sleep 4
    # File.delete file if delete_file
  end

  desc "Seed or update settings"
  task :seed, [:spreadsheet_key, :worksheet_title] => [:environment] do |t, args|
    key = args[:spreadsheet_key] || GoogleDriveSync.default_key
    title = args[:worksheet_title] || 'Settings'
    # Rake::Task['gds:download'].invoke key, title
    file = "tmp/#{title}-#{Time.now.strftime('%y%m%d-%H%M%S')}.csv"
    GoogleDriveSync::Task.new(key, title).download(file)
    data = CSV.read(file, headers: true).map(&:to_hash)
    data.each do |row|
      next unless row['name']
      Setting.set row['name'], row['value'], row['description']
      # setting = Setting.find_or_initialize_by name: row['name']
      # setting.assign_attributes value: row['value'], description: row['description']
      # setting.save
    end
  end

  desc "Print default url"
  task :url => :environment do
    puts GoogleDriveSync.default_url
  end

  desc "Open default Google Spreadsheet in browser"
  task :open => :environment do
    # Launchy.open(GoogleDriveSync.default_url)
    `open #{GoogleDriveSync.default_url}`
  end
end
