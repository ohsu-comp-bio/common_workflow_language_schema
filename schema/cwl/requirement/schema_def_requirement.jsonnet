local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local ProcessRequirement = CWL.classes.ProcessRequirement;
local SchemaDef = CWL.classes.SchemaDef;

doc(|||
  This field consists of an array of type definitions which must be used when
  interpreting the `inputs` and `outputs` fields.  When a symbolic type is
  encountered that is not in [`Datatype`](#datatype), the implementation must
  check if the type is defined in `schemaDefs` and use that definition.If the
  type is not found in `schemaDefs`, it is an error.  The entries in
  `schemaDefs` must be processed in the order listed such that later schema
  definitions may refer to earlier schema definitions.
|||) +

ProcessRequirement + record("SchemaDefRequirement") {
  fields +: [
    doc("The list of type definitions") +
    field("types", Avro.array([SchemaDef])),
  ]
}
