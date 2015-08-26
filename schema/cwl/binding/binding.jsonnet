local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local Expression = CWL.classes.Expression;

record("Binding") {
  fields: [
    doc("Only applies when `type` is `File`.  Read up to the first 64 KiB of
        text from the file and place it in the 'contents' field of the file
        object for manipulation by expressions.") + 
    field("loadContents", [Avro.Null, Avro.boolean]),

    doc("Only applies when `type` is `File`.  Describes files that must be
        included alongside the primary file.

        If the value is an expression, the context of the expression is the
        input or output File parameter to which this binding applies.

        If the value is a string, it specifies that the following pattern
        should be applied to the primary file:
          1. If string begins with one or more caret `^` characters, for each
            caret, remove the last file extension from the path (the last
            period `.` and all following characters).  If there are no file
            extensions, the path is unchanged.
          2. Append the remainder of the string to the end of the file path.") +
    field("secondaryFiles", [
      Avro.Null,
      Avro.string,
      Avro.array([Avro.string, Expression]),  
    ])
  ]
}
