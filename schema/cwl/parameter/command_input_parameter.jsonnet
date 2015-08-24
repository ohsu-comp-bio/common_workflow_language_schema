local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local CommandLineBinding = CWL.classes.CommandLineBinding;
local CommandOutputBinding = CWL.classes.CommandOutputBinding;
local OutputParameter = CWL.classes.OutputParameter;

doc("An input parameter for a CommandLineTool.") +
OutputParameter + record("CommandInputParameter") {
  binding:: CommandLineBinding,

  fields +: [
    doc("Describes how to handle the concrete outputs of a process step (such as
        files created by a program) and describe them in the process output
        parameter.") +
    field("outputBinding", [Avro.Null, CommandOutputBinding]),
  ]
}
