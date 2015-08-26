$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require "rspec/core/rake_task"
require "common_workflow_language_schema"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :build do
  File.open('dist/cwl.avpr', 'w') do |file|
    schema = CommonWorkflowLanguageSchema::Schema.new

    # Serialize to JSON and back to a hash...
    protocol = JSON.load(schema.to_avro_protocol.to_s)

    # Then prettify it!
    json = JSON.pretty_generate(protocol)

    file.write json
  end
end
