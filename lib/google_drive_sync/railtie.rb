module GoogleDriveSync
  class Railtie < Rails::Railtie
    rake_tasks do
      # load 'tasks/seed.rake'
      load 'tasks/google_drive_sync_tasks.rake'
    end
  end
end
