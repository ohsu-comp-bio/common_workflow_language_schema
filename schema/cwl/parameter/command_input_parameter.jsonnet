local Avro = import "../../avro.jsonnet";
local record = Avro.record;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local CommandLineBinding = CWL.classes.CommandLineBinding;
local InputParameter = CWL.classes.InputParameter;

doc("An input parameter for a CommandLineTool.") +
InputParameter + record("CommandInputParameter") {
  binding:: CommandLineBinding,
}
