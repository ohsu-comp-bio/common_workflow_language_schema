local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;
local default = Util.default;

local CWL = import "../../cwl.jsonnet";
local LinkMergeMethod = CWL.classes.LinkMergeMethod;

doc(|||
  The input of a workflow step connects an upstream parameter (from the
  workflow inputs, or the outputs of other workflows steps) with the input
  parameters of the underlying process.
  
  ## Input object ##
  A WorkflowStepInput object must contain an `id` field in the form
  `#fieldname` or `#stepname.fieldname`.  When the `id` field contains a
  period `.` the field name consists of the characters following the final
  period.  This defines a field of the workflow step input object with the
  value of the `source` parameter(s).
  
  ## Merging ##
  If the sink parameter is an array, or named in a [workflow
  scatter](#workflowstep) operation, there may be multiple inbound data links
  listed in the `connect` field.  The values from the input links are merged
  depending on the method specified in the `linkMerge` field.  If not
  specified, the default method is \"merge_nested\".
  
  * **merge_nested**
    The input must be an array consisting of exactly one entry for each
    input link.  If \"merge_nested\" is specified with a single link, the
    value from the link must be wrapped in a single-item list.
  
  * **merge_flattened**
  
    1. The source and sink parameters must be compatible types, or the source
       type must be compatible with single element from the \"items\" type of
       the destination array parameter.
  
    2. Source parameters which are arrays are concatenated.
       Source parameters which are single element types are appended as
       single elements.
|||) +

record("WorkflowStepInput") {
  fields: [
    doc("A unique identifier for this workflow input parameter.") +
    field("id", Avro.string),

    doc("Specifies one or more workflow parameters that will provide input to
        the underlying process parameter.") +
    field("source", [Avro.Null, Avro.string, Avro.array([Avro.string])]),

    doc(|||
      The method to use to merge multiple inbound links into a single array.
      If not specified, the default method is \"merge_nested\".
    |||) +
    field("linkMerge", [LinkMergeMethod]) +
    default("MERGE_NESTED"),

    doc(|||
      The default value for this parameter if there is no `source`
      field.
    |||) +
    field("default", Avro.allTypes),
  ]
}
