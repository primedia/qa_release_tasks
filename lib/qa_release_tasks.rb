$:.unshift File.join(File.dirname(__FILE__))
require 'cli'
require 'git/commands'
require 'git/release_notes'
require 'git/tagger'
require 'tasks/qa_release'

module QaReleaseTasks
  VERSION = '1.0.1'

  def self.version
    VERSION
  end
end
