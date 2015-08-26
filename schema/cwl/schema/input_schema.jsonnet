local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local Binding = CWL.classes.Binding;
local Schema = CWL.classes.Schema;

Schema + record("InputSchema") {
  fields +: [ 
    doc("Describes how to handle a value in the input object convert it into a
        concrete form for execution, such as command line parameters.") +
    field("inputBinding", [Avro.Null, Binding])
  ]
}
