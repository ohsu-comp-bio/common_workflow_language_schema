local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local Process = CWL.classes.Process;
local WorkflowStep = CWL.classes.WorkflowStep;

doc("A workflow is a process consisting of one or more `steps`.  Each
    step has input and output parameters defined by the `inputs` and `outputs`
    fields.  A workflow executes as described in [execution model]
    (#workflow_graph).

    # Dependencies #

    Dependencies between parameters are expressed using the `source` field on
    [workflow step input parameters](#workflowstepinput) and [workflow output
    parameters](#workflowoutputparameter).

    The `source` field expresses the dependency of one parameter on another
    such that when a value is associated with the parameter specified by
    `source`, that value is propagated to the destination parameter.  When all
    data links inbound to a given step are fufilled, the step is ready to
    execute.

    # Extensions #

    [ScatterFeatureRequirement](#scatterfeaturerequirement) and
    [SubworkflowFeatureRequirement](#subworkflowfeaturerequirement) are
    available as standard extensions to core workflow semantics.") +

Process + record("Workflow") {
  fields +: [
    field("class", Avro.string),

    doc("The individual steps that make up the workflow.  Each step is executed
        when all of its input data links are fufilled.  An implementation may
        choose to execute the steps in a different order than listed and/or
        execute steps concurrently, provided that dependencies between steps
        are met.") +
    field("steps", Avro.array([WorkflowStep])),
  ]
}
