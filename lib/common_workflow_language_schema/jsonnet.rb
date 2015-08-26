require 'ptools'

module CommonWorkflowLanguageSchema
  module Jsonnet

    def self.render(file_path, render_doc=false)
      unless File.which('jsonnet')
        raise 'jsonnet executable not found in path'
      end

      output = `jsonnet --var DOC=#{render_doc} #{file_path}`

      document = JSON.parse(output)

      if render_doc
        # We're going to treat doc strings in the doc as heredocs.
        # Remove any leading indentation.
        document['types'].each do |type|
          type['doc'].strip_heredoc! if type['doc']

          if type['fields']
            type['fields'].each do |field|
              field['doc'].strip_heredoc! if field['doc']
            end
          end
        end
      end

      document
    end
  end
end
