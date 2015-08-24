local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local CWL = import "../../cwl.jsonnet";
local Binding = CWL.classes.Binding;
local Parameter = CWL.classes.Parameter;

Parameter + record("InputParameter") {
  binding:: Binding,

  fields +: [
    field("id", "string"),

    field("inputBinding", [
      Avro.Null,
      self.binding,
    ])
  ]
}
