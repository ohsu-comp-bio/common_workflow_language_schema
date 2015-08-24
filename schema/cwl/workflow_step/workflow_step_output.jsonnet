local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

doc("Associate an output parameter of the underlying process with a workflow
    parameter.  The workflow parameter (given in the `id` field) be may be used
    as a `source` to connect with input parameters of other workflow steps, or
    with an output parameter of the process.") +

record("WorkflowStepOutput") {
  fields: [
    doc("A unique identifier for this workflow output parameter.  This is the
          identifier to use in the `source` field of `WorkflowStepInput` to
          connect the output value to downstream parameters.") +
    field("id", Avro.string),
  ]
}
