local Avro = import "../../avro.jsonnet";
local enum = Avro.enum;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

doc("CWL data types are based on Avro schema declarations.  Refer to the [Avro
    schema declaration documentation]
    (https://avro.apache.org/docs/current/spec.html#schemas) for detailed
    information.  In addition, CWL defines [`File`](#file) as a special record
    type.

    ## Primitive types ##

    * **null**: no value
    * **boolean**: a binary value
    * **int**: 32-bit signed integer
    * **long**: 64-bit signed integer
    * **float**: single precision (32-bit) IEEE 754 floating-point number
    * **double**: double precision (64-bit) IEEE 754 floating-point number
    * **bytes**: sequence of uninterpreted 8-bit unsigned bytes
    * **string**: Unicode character sequence

    ## Complex types ##
    * **record**: An object with one or more fields defined by name and type
    * **enum**: A value from a finite set of symbolic values
    * **array**: An ordered sequence of values
    * **map**: An unordered collection of key/value pairs

    ## File type ##
    See [File](#file) below.") +

enum("Datatype", [
  "NULL",
  "BOOLEAN",
  "INT",
  "LONG",
  "FLOAT",
  "DOUBLE",
  "BYTES",
  "STRING",
  "RECORD",
  "ENUM",
  "ARRAY",
  "MAP",
  "FILE",
])
