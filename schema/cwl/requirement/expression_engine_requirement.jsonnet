local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local ProcessRequirement = CWL.classes.ProcessRequirement;

doc("Define an expression engine, as described in [Expressions]
    (#expressions).") +
ProcessRequirement + record("ExpressionEngineRequirement") {
  fields +: [
    doc("Used to identify the expression engine in the `engine` field of
        Expressions.") +
    field("id", Avro.string),

    doc("Requirements to run this expression engine, such as DockerRequirement
        for specifying a container to run the engine.") +
    field("requirements", [Avro.Null, Avro.array([ProcessRequirement])]),

    doc("The command line to invoke the expression engine.") +
    field("engineCommand", [Avro.Null, Avro.string, Avro.array([Avro.string])]),

    doc("Additional configuration or code fragments that will also be passed to
        the expression engine.  The semantics of this field are defined by the
        underlying expression engine.  Intended for uses such as providing
        function definitions that will be called from CWL expressions.") +
    field("engineConfig", [Avro.Null, Avro.array([Avro.string])]),
  ]
}
