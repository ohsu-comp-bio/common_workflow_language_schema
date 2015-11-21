local Avro = import "../../avro.jsonnet";
local record = Avro.record;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local ProcessRequirement = CWL.classes.ProcessRequirement;

doc(|||
  Indicates that the workflow platform must support nested workflows in
  the `run` field of (WorkflowStep)(#workflowstep).
|||) +

ProcessRequirement + record("SubworkflowFeatureRequirement")
