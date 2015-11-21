local renderDoc = std.extVar("DOC") == "true";

{
  doc(contents):: { [if renderDoc then "doc"]: contents },

  default(value):: {default: value},

  isAvroObj:: function(obj) std.type(obj) == "object" && (obj.type == "record" || obj.type == "enum"),

  /* Helper function to normalize an array by replace any objects with its name
     in an array. */
  normalizeObject(obj):: if std.type(obj) == "array" then self.normalizeArray(obj)
                            else if self.isAvroObj(obj) then obj.name
                            else obj,

  normalizeArray(objects):: std.map(self.normalizeObject, objects),
}
