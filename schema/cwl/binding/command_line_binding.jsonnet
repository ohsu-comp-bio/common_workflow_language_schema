local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;
local default = Util.default;

local CWL = import "../../cwl.jsonnet";
local Binding = CWL.classes.Binding;
local Expression = CWL.classes.Expression;

doc("When listed under `inputBinding` in the input schema, the term
    \"value\" refers to the the corresponding value in the input object.  For
    binding objects listed in `CommandLineTool.arguments`, the term \"value\"
    refers to the effective value after evaluating `valueFrom`.

    The binding behavior when building the command line depends on the data
    type of the value.  If there is a mismatch between the type described by
    the input schema and the effective value, such as resulting from an
    expression evaluation, an implementation must use the data type of the
    effective value.

      - **string**: Add `prefix` and the string to the command line.

      - **number**: Add `prefix` and decimal representation to command line.

      - **boolean**: If true, add `prefix` to the command line.  If false, add
          nothing.

      - **File**: Add `prefix` and the value of
        [`File.path`](#file) to the command line.

      - **array**: If `itemSeparator` is specified, add `prefix` and the join
          the array into a single string with `itemSeparator` separating the
          items.  Otherwise first add `prefix`, then recursively process
          individual elements.

      - **object**: Add `prefix` only, and recursively add object fields for
          which `inputBinding` is specified.

      - **null**: Add nothing.") +
Binding + record("CommandLineBinding") {
  fields +: [
    doc("The sorting key.  Default position is 0.") +
    field("position", Avro.int) +
    default(0),

    doc("Command line prefix to add before the value.") +
    field("prefix", [Avro.Null, Avro.string]),

    doc("If true (default), then the prefix and value must be added as separate
        command line arguments; if false, prefix and value must be concatenated
        into a single command line argument.") +
    field("separate", Avro.boolean) +
    default(true),

    doc("Join the array elements into a single string with the elements
        separated by by `itemSeparator`.") +
    field("itemSeparator", [Avro.Null, Avro.boolean]),

    doc("If `valueFrom` is a constant string value, use this as the value and
        apply the binding rules above.

        If `valueFrom` is an expression, evaluate the expression to yield the
        actual value to use to build the command line and apply the binding
        rules above.  If the inputBinding is associated with an input
        parameter, the \"context\" of the expression will be the value of the
        input parameter.

        When a binding is part of the `CommandLineTool.arguments` field,
        the `valueFrom` field is required.") +
    field("valueFrom", [Avro.Null, Avro.string, Expression]),
  ]
}
