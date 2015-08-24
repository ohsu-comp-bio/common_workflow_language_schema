local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;
local default = Util.default;

local CWL = import "../../cwl.jsonnet";
local LinkMergeMethod = CWL.classes.LinkMergeMethod;
local OutputParameter = CWL.classes.OutputParameter;

doc("Describe an output parameter of a workflow.  The parameter must be
    connected to one or more parameters defined in the workflow that will
    provide the value of the output parameter.") +

OutputParameter + record("WorkflowOutputParameter") {
  fields +: [
    doc("Specifies one or more workflow parameters that will provide this output
        value.") +
    field("source", [Avro.Null, Avro.string, Avro.array([Avro.string])]),

    doc("The method to use to merge multiple inbound links into a single array.
        If not specified, the default method is \"merge_nested\".") +
    field("linkMerge", LinkMergeMethod) +
    default("MERGE_NESTED"),
  ]
}
