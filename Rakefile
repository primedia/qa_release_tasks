require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'
require 'spec/rake/spectask'

require 'lib/qa_release_tasks'

GEM = "qa_release_tasks"
GEM_VERSION = QaReleaseTasks.version
AUTHORS = "Jason Noble", "Rein Henrichs"
SUMMARY = "A gem that provides workflow driven rake tasks for git QA branch management"

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.authors = AUTHORS
  s.executables = ['git-changelog']
  
  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
end

task :default => :spec

task :make => :make_spec do
  system("./bin/git-changelog --help > README && ./bin/git-changelog -a --no-limit > HISTORY")
end

desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fs --color)
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION}}
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

namespace :gem do
  desc "validate the gem like github does"
  task :validate do
    require 'rubygems/specification'
    data = File.read("#{GEM}.gemspec")
    spec = nil

    if data !~ %r{!ruby/object:Gem::Specification}
      Thread.new { spec = eval("$SAFE = 3\n#{data}") }.join
    else
      spec = YAML.load(data)
    end

    puts spec
    puts spec.validate ? "OK" : "FAIL"
  end
end