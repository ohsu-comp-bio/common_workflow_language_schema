local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;
local default = Util.default;

local CWL = import "../../cwl.jsonnet";
local Datatype = CWL.classes.Datatype;
local Schema = CWL.classes.Schema;

doc("Define an input or output parameter to a process.") +
record("Parameter") + {
  fields: [

    doc("Specify valid types of data that may be assigned to this parameter.") +
    field("type", [
      Avro.Null,
      Datatype,
      Schema,
      Avro.string,
      Avro.array([Datatype, Schema, Avro.string]),
    ]),

    doc("A short, human-readable label of this parameter object.") + 
    field("label", [Avro.Null, Avro.string]),

    doc("A long, human-readable description of this parameter object.") +
    field("description", [Avro.Null, Avro.string]),

    doc("Currently only applies if `type` is `File`.  A value of `true`
        indicates that the file is read or written sequentially without seeking.
        An implementation may use this flag to indicate whether it is valid to
        stream file contents using a named pipe.  Default: `false`.") +
    field("streamable", Avro.boolean) +
    default(true),
  ],
}
