# encoding: utf-8

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development, :test)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'rake'

task default: [:rubocop, 'gemspec:validate', 'gloader:specs:unit', 'gloader:specs:integration']

require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'gloader'))
require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'gloader', 'version'))
require 'rake/testtask'
namespace :gloader do
  namespace :specs do
    Rake::TestTask.new('unit') do |t|
      t.pattern = 'spec/unit/gloader/**/*_spec.rb'
    end
    Rake::TestTask.new('integration') do |t|
      t.pattern = 'spec/integration/gloader/**/*_spec.rb'
    end
  end
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = 'gloader'
  gem.version = GLoader::VERSION
  gem.homepage = 'http://github.com/bendodd/gloader'
  gem.license = 'MIT'
  gem.summary = %Q{Grinder Load Tester}
  gem.description = %Q{Buids Grinder load test platform and controls test runs}
  gem.email = 'mail@bendodd.com'
  gem.authors = ['Benedict Dodd']
end
Jeweler::RubygemsDotOrgTasks.new

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "gloader #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'rubocop/rake_task'

desc 'Run RuboCop on the lib directory'
Rubocop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
end
