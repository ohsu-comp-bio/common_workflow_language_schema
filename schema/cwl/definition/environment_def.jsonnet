local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local Expression = CWL.classes.Expression;

doc("Define an environment variable that will be set in the runtime environment
    by the workflow platform when executing the command line tool.  May be the
    result of executing an expression, such as getting a parameter from
    input.") +
record("EnvironmentDef") {
  fields: [
    doc("The environment variable name.") +
    field("envName", Avro.string),

    doc("The environment variable value.") +
    field("envValue", [Avro.string, Expression]),
  ]
}
