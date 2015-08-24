local Avro = import "../../avro.jsonnet";
local enum = Avro.enum;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

doc("The input link merge method, described in
    [WorkflowStepInput](#workflowstepinput).") +
enum("LinkMergeMethod", [
  "MERGE_NESTED",
  "MERGE_FLATTENED"
])
