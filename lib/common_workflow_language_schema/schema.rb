require 'ptools'
require 'json'

module CommonWorkflowLanguageSchema
  module Schema

    def self.to_json(render_doc=false)
      unless jsonnet_executable_exists?
        raise 'jsonnet executable not found in path'
      end

      if render_doc
        doc = `jsonnet --var DOC=true #{schema_path}`

        schema = JSON.parse(doc)

        # We're going to treat doc strings in the schema as heredocs.
        # Remove any leading indentation.
        schema['types'].each do |type|
          type['doc'].strip_heredoc! if type['doc']

          if type['fields']
            type['fields'].each do |field|
              field['doc'].strip_heredoc! if field['doc']
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
      File.join(root_dir, 'schema', 'cwl.jsonnet')
    end

    def self.jsonnet_executable_exists?
      File.which('jsonnet')
    end

    def self.root_dir
      File.expand_path('../../../', __FILE__)
    end

  end
end
