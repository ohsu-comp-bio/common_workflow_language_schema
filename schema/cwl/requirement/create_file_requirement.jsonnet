local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local ProcessRequirement = CWL.classes.ProcessRequirement;
local FileDef = CWL.classes.FileDef;

doc("Define a list of files that must be created by the workflow platform in
    the designated output directory prior to executing the command line tool.
    See `FileDef` for details.") +
ProcessRequirement + record("CreateFileRequirement") {
  fields +: [
    doc("The list of files.") +
    field("fileDef", Avro.array([FileDef])),
  ]
}
