require 'rake/testtask'

Rake::TestTask.new do |task|
  task.libs << "test"
  task.test_files = FileList['test/*test.rb']
  task.verbose = true
end

task :document do
  sh 'bundle exec rspec --format documentation'
end

task default: :test
