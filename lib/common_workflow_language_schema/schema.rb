require 'ptools'
require 'json'

module CommonWorkflowLanguageSchema
  module Schema

    VERSION = "draft-2"

    def self.to_json(render_doc=false)
      unless jsonnet_executable_exists?
        raise "jsonnet executable not found in path"
      end

      if render_doc
        doc = `jsonnet --var DOC=true #{schema_path}`

        schema = JSON.parse(doc)

        # We're going to treat doc strings in the schema as heredocs.
        # Remove any leading indentation.
        schema["types"].each do |type|
          type["doc"].strip_heredoc! if type["doc"]

          if type["fields"]
            type["fields"].each do |field|
              field["doc"].strip_heredoc! if field["doc"]
            end
          end
        end
          
        JSON.pretty_generate(schema)

      else
        `jsonnet --var DOC=false #{schema_path}`
      end
    end

    protected

    def self.schema_path
      File.join(spec.gem_dir, "schema", "cwl.jsonnet")
    end

    def self.jsonnet_executable_exists?
      File.which('jsonnet')
    end

    def self.spec
      Gem::Specification.find_by_name('common_workflow_language_schema')
    end

  end
end
