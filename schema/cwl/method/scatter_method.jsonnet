local Avro = import "../../avro.jsonnet";
local enum = Avro.enum;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

doc(|||
  The scatter method, as described in [workflow step scatter]
  (#workflowstep).
|||) +

enum("ScatterMethod", [
  "DOTPRODUCT",
  "NESTED_CROSSPRODUCT",
  "FLAT_CROSSPRODUCT",
])
