local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

doc("A process requirement declares a prerequisite that may or must be fulfilled
    before executing a process.  See [`Process.hints`](#process) and
    [`Process.requirements`](#process).

    Process requirements are the primary mechanism for specifying extensions to
    the CWL core specification.") +

record("ProcessRequirement") {
  fields: [
    doc("The specific requirement type.") +
    field("class", Avro.string)
  ]
}
