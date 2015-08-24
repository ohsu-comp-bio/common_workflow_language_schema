local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local Parameter = CWL.classes.Parameter;

Parameter + record("InputParameter") {
  fields +: [
    doc("The unique identifier for this parameter object.") +
    field("id", "string"),
  ]
}
