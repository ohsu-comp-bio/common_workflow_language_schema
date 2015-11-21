local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local CommandOutputBinding = CWL.classes.CommandOutputBinding;
local OutputSchema = CWL.classes.OutputSchema;

OutputSchema + record("CommandOutputSchema") {
  fields +: [
    doc(|||
      Describes how to handle the concrete outputs of a process step (such as
      files created by a program) and describe them in the process output
      parameter.
    |||) +
    field("outputBinding", [Avro.Null, CommandOutputBinding]),
  ]
}
