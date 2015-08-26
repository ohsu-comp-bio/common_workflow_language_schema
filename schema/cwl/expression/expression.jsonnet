local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local JsonPointer = CWL.classes.JsonPointer;

doc("Define an expression that will be evaluated and used to modify the behavior
    of a tool or workflow.  See [Expressions](#expressions) for more information
    about expressions and [ExpressionEngineRequirement]
    (#expressionenginerequirement) for information on how to define a expression
    engine.") +

record("Expression") + {
  fields: [
    doc("Either `cwl:JsonPointer` or a reference to an
        ExpressionEngineRequirement defining which engine to use.") +
    field("engine", [JsonPointer, Avro.string]),

    doc("The code to be executed by the expression engine.") +
    field("script", Avro.string)
  ]
}
