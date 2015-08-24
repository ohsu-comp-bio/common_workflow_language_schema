local Avro = import "../../avro.jsonnet";
local enum = Avro.enum;
local doc = import "../../util.jsonnet".doc;

doc("The Any type validates for any non-null value.") +
enum("Any", ["ANY"])
