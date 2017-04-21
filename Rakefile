Dir[File.join(File.dirname(__FILE__), 'lib/tasks/*.rake')].each {|f| load f }

task :default => [:gds, :seed]

# task :default => :test
# require 'rake/testtask'
# Rake::TestTask.new(:test) do |test|
#   test.libs << 'lib' << 'test'
#   test.pattern = 'test/**/*_test.rb'
#   test.verbose = true
# end
