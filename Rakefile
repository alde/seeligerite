require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = false
end


if RUBY_VERSION < "1.9"

  require 'rubygems'
  require 'rcov/rcovtask'

  Rcov::RcovTask.new do |t|
    t.libs << "test"
    t.test_files = FileList['test/**/*_test.rb']
    t.verbose = false
  end

end
