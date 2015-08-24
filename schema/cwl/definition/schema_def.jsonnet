local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

record("SchemaDef") {
  fields: [
    doc("The type name being defined.") +
    field("name", Avro.string),
  ]
}
