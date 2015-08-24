local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local ProcessRequirement = CWL.classes.ProcessRequirement;

doc("Indicates that the workflow platform must support the `scatter` and
    `scatterMethod` fields of [WorkflowStep](#workflowstep).") +
ProcessRequirement + record("ScatterFeatureRequirement")
