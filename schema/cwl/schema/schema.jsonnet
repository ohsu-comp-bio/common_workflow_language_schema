local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local Datatype = CWL.classes.Datatype;

doc("A schema defines a parameter type.") +
record("Schema") {

  schemaType:: self.name,

  fields: [

    doc("The data type of this parameter.") +
    field("type", [
      Datatype,
      self.schemaType,
      Avro.string,
      Avro.array([Datatype, self.schemaType, Avro.string]),
    ]),

    doc("When `type` is `record`, defines the fields of the record.") +
    field("fields", [
      Avro.Null,
      Avro.array([Avro.Null, Avro.array([self.name])]),
    ]),

    doc("When `type` is `enum`, defines the set of valid symbols.") +
    field("symbols", [Avro.Null, Avro.array([Avro.string])]),

    doc("When `type` is `array`, defines the type of the array elements.") +
    field("items", [
      Avro.Null,
      Datatype,
      self.name,
      Avro.string,
      Avro.array([Avro.Null, Datatype, self.name, Avro.string]),
    ]),

    doc("When `type` is `map`, defines the value type for the key/value
        pairs.") +
    field("values", [
      Avro.Null,
      Datatype,
      self.name,
      Avro.string,
      Avro.array([Datatype, self.name, Avro.string]),
    ]),
  ]
}
