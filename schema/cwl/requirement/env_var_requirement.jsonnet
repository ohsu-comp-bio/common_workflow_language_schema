local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local ProcessRequirement = CWL.classes.ProcessRequirement;
local EnvironmentDef = CWL.classes.EnvironmentDef;

doc(|||
  Define a list of environment variables which will be set in the
  execution environment of the tool.  See `EnvironmentDef` for details.
|||) +

ProcessRequirement + record("EnvVarRequirement") {
  fields +: [
    doc("The list of environment variables.") +
    field("envDef", Avro.array([EnvironmentDef])),
  ]
}
