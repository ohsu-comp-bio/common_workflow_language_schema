$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require "rspec/core/rake_task"
require "common_workflow_language_schema"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :build do
  File.open('dist/cwl.avpr', 'w') do |file|
    file.write CommonWorkflowLanguageSchema::Schema.to_json
  end
end
