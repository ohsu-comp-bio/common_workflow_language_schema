local renderDoc = std.extVar("DOC") == "true";

{
  doc(contents):: if renderDoc then {doc: contents} else {doc:: contents},

  default(value):: {default: value},

  /* Helper function to normalize an array by replace any objects with its name
     in an array. */
  normalizeArray(objects):: std.map(function(obj) if std.type(obj) == "object" && std.objectHas(obj, "name") then obj.name else obj, objects),

  binding(object)::
    {
      binding:: object
    }
}
