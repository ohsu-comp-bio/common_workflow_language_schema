local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local CommandInputParameter = CWL.classes.CommandInputParameter;
local CommandLineBinding = CWL.classes.CommandLineBinding;
local CommandOutputParameter = CWL.classes.CommandOutputParameter;
local Expression = CWL.classes.Expression;
local Process = CWL.classes.Process;

doc("A CommandLineTool process is a process implementation for executing a
    non-interactive application in a POSIX environment.  To accommodate
    the enormous variety in syntax and semantics for input, runtime
    environment, invocation, and output of arbitrary programs, CommandLineTool
    uses an \"input binding\" that describes how to translate input
    parameters to an actual program invocation, and an \"output binding\" that
    describes how to generate output parameters from program output.

    # Input binding #
    The tool command line is built by applying command line bindings to the
    input object.  Bindings are listed either as part of an [input
    parameter](#commandinputparameter) using the `inputBinding` field, or
    separately using the `arguments` field of the CommandLineTool.
    The algorithm to build the command line is as follows.  In this algorithm,
    the sort key is a list consisting of one or more numeric or string
    elements.  Strings are sorted lexicographically based on UTF-8 encoding.

      1. Collect `CommandLineBinding` objects from `arguments`.  Assign a sorting
      key `[position, i]` where `position` is
      [`CommandLineBinding.position`](#commandlinebinding) and `i`
      is the index in the `arguments` list.

      2. Collect `CommandLineBinding` objects from the `inputs` schema and
      associate them with values from the input object.  Where the input type
      is a record, array, or map, recursively walk the schema and input object,
      collecting nested `CommandLineBinding` objects and associating them with
      values from the input object.

      3. Create a sorting key by taking the value of the `position` field at
      each level leading to each leaf binding object.  If `position` is not
      specified, it is not added to the sorting key.  For bindings on arrays
      and maps, the sorting key must include the array index or map key
      following the position.  If and only if two bindings have the same sort
      key, the tie must be broken using the ordering of the field or parameter
      name immediately containing the leaf binding.

      4. Sort elements using the assigned sorting keys.  Numeric entries sort
      before strings.

      5. In the sorted order, apply the rules defined in
      [`CommandLineBinding`](#commandlinebinding) to convert bindings to actual
      command line elements.
      6. Insert elements from `baseCommand` at the beginning of the command
      line.

    # Runtime environment #

    All files listed in the input object must be made available in the runtime
    environment.  The implementation may use a shared or distributed file
    system or transfer files via explicit download.  Implementations may choose
    not to provide access to files not explicitly specified by the input object
    or process requirements.

    Output files produced by tool execution must be written to the **designated
    output directory**.

    The initial current working directory when executing the tool must be the
    designated output directory.

    When executing the tool, the child process must not inherit environment
    variables from the parent process.  The tool must execute in a new, empty
    environment, containing only environment variables defined by
    [EnvVarRequirement](#envvarrequirement), the default environment of the
    Docker container specified in [DockerRequirement](#dockerrequirement) (if
    applicable), and `TMPDIR`.

    The `TMPDIR` environment variable must be set in the runtime environment to
    the **designated temporary directory**.  Any files written to the
    designated temporary directory may be deleted by the workflow platform when
    the tool invocation is complete.

    An implementation may forbid the tool from writing to any location in the
    runtime environment file system other than the designated temporary
    directory and designated output directory.  An implementation may provide
    read-only input files, and disallow in-place update of input files.
    The standard input stream and standard output stream may be redirected as
    described in the `stdin` and `stdout` fields.

    ## Extensions ##

    [DockerRequirement](#dockerrequirement),
    [CreateFileRequirement](#createfilerequirement), and
    [EnvVarRequirement](#envvarrequirement) are available as standard
    extensions to core command line tool semantics for defining the runtime
    environment.

    # Execution #

    Once the command line is built and the runtime environment is created, the
    actual tool is executed.

    The standard error stream and standard output stream (unless redirected by
    setting `stdout`) may be captured by platform logging facilities for
    storage and reporting.

    Tools may be multithreaded or spawn child processes; however, when the
    parent process exits, the tool is considered finished regardless of whether
    any detached child processes are still running.  Tools must not require any
    kind of console, GUI, or web based user interaction in order to start and
    run to completion.

    The exit code of the process indicates if the process completed
    successfully.  By convention, an exit code of zero is treated as success
    and non-zero exit codes are treated as failure.  This may be customized by
    providing the fields `successCodes`, `temporaryFailCodes`, and
    `permanentFailCodes`.  An implementation may choose to default unspecified
    non-zero exit codes to either `temporaryFailure` or `permanentFailure`.

    # Output binding #

    If the output directory contains a file named \"cwl.output.json\", that file
    must be loaded and used as the output object.  Otherwise, the output object
    must be generated by walking the parameters listed in `outputs` and
    applying output bindings to the tool output.  Output bindings are
    associated with output parameters using the `outputBinding` field.  See
    [`CommandOutputBinding`](#commandoutputbinding) for details.") +

Process + record("CommandLineTool") {

  inputParameter:: CommandInputParameter,
  outputParameter:: CommandOutputParameter,

  fields +: [
    field("class", Avro.string),

    doc("Specifies the program to execute.  If the value is an array, the first
        element is the program to execute, and subsequent elements are placed
        at the beginning of the command line in prior to any command line
        bindings.  If the program includes a path separator character it must
        be an absolute path, otherwise it is an error.  If the program does not
        include a path separator, search the `$PATH` variable in the runtime
        environment of the workflow runner find the absolute path of the
        executable.") +
    field("baseCommand", [Avro.string, Avro.array([Avro.string])]),

    doc("Command line bindings which are not directly associated with input
        parameters.") +
    field("arguments", [
      Avro.Null,
      Avro.array([Avro.string, CommandLineBinding]),
    ]),

    doc("A path to a file whose contents must be piped into the command's
        standard input stream.") +
    field("stdin", [Avro.Null, Avro.string, Expression]),

    doc("Capture the command's standard output stream to a file written to
        the designated output directory.
        If `stdout` is a string, it specifies the file name to use.
        If `stdout` is an expression, the expression is evaluated and must
        return a string with the file name to use to capture stdout.  If the
        return value is not a string, or the resulting path contains illegal
        characters (such as the path separator `/`) it is an error.") +
    field("stdout", [Avro.Null, Avro.string, Expression]),

    doc("Exit codes that indicate the process completed successfully.") +
    field("statusCodes", [Avro.Null, Avro.array([Avro.int])]),

    doc("Exit codes that indicate the process failed due to a possibly
        temporary condition, where excuting the process with the same
        runtime environment and inputs may produce different results.") +
    field("temporaryFailCodes", [Avro.Null, Avro.array([Avro.int])]),

    doc("Exit codes that indicate the process failed due to a permanent logic
        error, where excuting the process with the same runtime environment and
        same inputs is expected to always fail.") +
    field("permanentFailCodes", [Avro.Null, Avro.array([Avro.int])]),
  ]
}
