local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local Any = CWL.classes.Any;
local Expression = CWL.classes.Expression;
local Process = CWL.classes.Process;

doc("Execute an expression as a process step.") +
Process + record("ExpressionTool") {
  fields +: [
    field("class", Avro.string),

    doc("The expression to execute.  The expression must return a JSON object which
        matches the output parameters of the ExpressionTool.") +
    field("expression", Expression),
  ]
}
