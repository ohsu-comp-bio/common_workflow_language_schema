local util = import "util.jsonnet";
{
  boolean: "boolean",
  int: "int",
  long: "long",
  string: "string",

  /* Note we have to use "Null" instead of "null" since "null gets parsed
     as a keyword in jsonnet. */
  Null: "null",

  record(name)::
    {
      name: name,
      type: "record"
    },

  enum(name, symbols)::
    {
      name: name,
      type: "enum",
      symbols: symbols,
    },

  array(types)::
    {
      type: "array",
      items: util.normalizeArray(types),
    },

  field(name, types)::
    {
      name: name,
      type: util.normalizeObject(types),
    },

}
