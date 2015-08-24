local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local File = CWL.classes.File;
local FileClass = CWL.classes.FileClass;

doc("Represents a file (or group of files if `secondaryFiles` is specified) that
    must be accessible by tools using standard POSIX file system call API such
    as open(2) and read(2).") +

record("File") {
  fields: [
    doc("Must be `File` to indicate this object describes a file.") +
    field("class", FileClass),

    doc("The path to the file.") +
    field("path", Avro.string),

    doc("Optional hash code for validating file integrity.  Currently must be
        in the form \"sha1$ + hexidecimal string\" using the SHA-1
        algorithm.") +
    field("checksum", Avro.array([Avro.Null, Avro.string])),

    doc("Optional file size.") + 
    field("size", Avro.array([Avro.Null, Avro.long])),

    doc("A list of additional files that are associated with the primary file
        and must be transferred alongside the primary file.  Examples include
        indexes of the primary file, or external references which must be
        included when loading primary document.  A file object listed in
        `secondaryFiles` may itself include `secondaryFiles` for which the same
        rules apply.") +
    field("secondaryFiles", Avro.array([Avro.Null, File])),
  ]
}
