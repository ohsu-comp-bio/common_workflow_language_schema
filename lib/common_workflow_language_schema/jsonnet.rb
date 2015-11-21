require 'ptools'

module CommonWorkflowLanguageSchema
  module Jsonnet

    def self.render(file_path, render_doc=false)
      unless File.which('jsonnet')
        raise 'jsonnet executable not found in path'
      end

      puts "jsonnet --var DOC=#{render_doc} #{file_path}"

      output = `jsonnet --var DOC=#{render_doc} #{file_path}`

      JSON.parse(output)
    end
  end
end
