module GoogleDriveSync
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/google_drive_sync_tasks.rake'
    end
  end
end
