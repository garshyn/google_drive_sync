$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'google_drive_sync/version'

Gem::Specification.new do |s|
  s.name        = 'google_drive_sync'
  s.version     = GoogleDriveSync::VERSION
  s.authors     = ['Andrew Garshyn']
  s.email       = ['garshyn@gmail.com']
  s.homepage    = 'http://garshyn.com'
  s.summary     = 'CSV (hosted on Google Drive) to YAML converter, YAML to CSV (uploader)'
  s.description = 'Used for syncing translations and seeds in Rails projects. Based on `google_drive` gem'
  s.license     = 'MIT'

  s.files = Dir['{lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']
  # s.test_files = Dir['spec/**/*']
  # s.require_paths = ['lib']

  s.add_dependency 'google_drive'
  s.add_dependency 'rails'
  # s.add_dependency 'launchy'
  # s.add_development_dependency 'rspec-rails'
end
