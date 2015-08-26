module CommonWorkflowLanguageSchema
  class Schema
    include TSort

    DEFAULT_SCHEMA_PATH = begin
                            root_path = File.expand_path('../../../', __FILE__)
                            File.join(root_path, 'schema', 'cwl.jsonnet')
                          end

    attr_reader :schema

    def initialize(schema_path=DEFAULT_SCHEMA_PATH)
      schema_contents = ::CommonWorkflowLanguageSchema::Jsonnet::render(schema_path)
      @schema = Hashie::Mash.new(schema_contents)
    end

    def to_avro_protocol
      # Clone the schema and update types based on a topological sort of the
      # "types" field. Avro requires that you first define types before
      # referencing them later on in the schema.
      sorted_schema = @schema.clone.update(types: tsort)

      # Serialize the schema to JSON. The Avro gem requires this.
      serialized_schema = JSON.dump(sorted_schema)

      # Finally, parse the protocol.
      Avro::Protocol.parse(serialized_schema)
    end

    protected

    def tsort_each_node
      @schema.types.each do |type|
        yield type
      end
    end

    def tsort_each_child(node, &block)
      # For the given node, traverse through the "type" attribute,
      # flattening any "array" types. Map each type back to schema.types
      node.
        fields.
        to_a.
        map(&:type).
        flatten.
        map{|type| type.is_a?(Hashie::Mash) ? type.items : type }.
        flatten.
        uniq.
        map{|type| schema.types.find{|t| t.name == type}}.
        compact.
        each do |node|
          yield node
        end
    end
  end
end
