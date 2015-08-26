{
  protocol: "CommonWorkflowLanguage",
  namespace: "com.github.common_workflow_language",
  version:: "draft-2",

  /* Manage all of the CWL types as "classes" so that we can refer to them by
     name in each source file. */
  classes:: {
    /* Bindings */
    Binding: import "cwl/binding/binding.jsonnet",
    CommandLineBinding: import "cwl/binding/command_line_binding.jsonnet",
    CommandOutputBinding: import "cwl/binding/command_output_binding.jsonnet",

    /* Datatypes */
    Any: import "cwl/datatypes/any.jsonnet",
    Datatype: import "cwl/datatypes/datatype.jsonnet",
    JsonPointer: import "cwl/datatypes/json_pointer.jsonnet",

    /* Definition */
    EnvironmentDef: import "cwl/definition/environment_def.jsonnet",
    FileDef: import "cwl/definition/file_def.jsonnet",
    SchemaDef: import "cwl/definition/schema_def.jsonnet",

    /* Expression */
    Expression: import "cwl/expression/expression.jsonnet",

    /* File */
    File: import "cwl/file/file.jsonnet",
    FileClass: import "cwl/file/file_class.jsonnet",

    /* Method */
    LinkMergeMethod: import "cwl/method/link_merge_method.jsonnet",
    ScatterMethod: import "cwl/method/scatter_method.jsonnet",

    /* Parameter */
    CommandInputParameter: import "cwl/parameter/command_input_parameter.jsonnet",
    InputParameter: import "cwl/parameter/input_parameter.jsonnet",
    OutputParameter: import "cwl/parameter/output_parameter.jsonnet",
    Parameter: import "cwl/parameter/parameter.jsonnet",
    WorkflowOutputParameter: import "cwl/parameter/workflow_output_parameter.jsonnet",

    /* Process */
    CommandLineTool: import "cwl/process/command_line_tool.jsonnet",
    ExpressionTool: import "cwl/process/expression_tool.jsonnet",
    Process: import "cwl/process/process.jsonnet",
    Workflow: import "cwl/process/workflow.jsonnet",

    /* Requirement */
    CreateFileRequirement: import "cwl/requirement/create_file_requirement.jsonnet",
    DockerRequirement: import "cwl/requirement/docker_requirement.jsonnet",
    EnvVarRequirement: import "cwl/requirement/env_var_requirement.jsonnet",
    ExpressionEngineRequirement: import "cwl/requirement/expression_engine_requirement.jsonnet",
    ProcessRequirement: import "cwl/requirement/process_requirement.jsonnet",
    ScatterFeatureRequirement: import "cwl/requirement/scatter_feature_requirement.jsonnet",
    SchemaDefRequirement: import "cwl/requirement/schema_def_requirement.jsonnet",
    SubworkflowFeatureRequirement: import "cwl/requirement/subworkflow_feature_requirement.jsonnet",

    /* Schema */
    CommandInputSchema: import "cwl/schema/command_input_schema.jsonnet",
    CommandOutputSchema: import "cwl/schema/command_output_schema.jsonnet",
    InputSchema: import "cwl/schema/input_schema.jsonnet",
    OutputSchema: import "cwl/schema/output_schema.jsonnet",
    Schema: import "cwl/schema/schema.jsonnet",

    /* Workflow Step */
    WorkflowStep: import "cwl/workflow_step/workflow_step.jsonnet",
    WorkflowStepInput: import "cwl/workflow_step/workflow_step_input.jsonnet",
    WorkflowStepOutput: import "cwl/workflow_step/workflow_step_output.jsonnet",
  },

  /* Flatten our "classes" collection into an array. This collection gets
     rendered within the Avro protocol. */
  types: std.map(function(field) self.classes[field], std.objectFields(self.classes)),
  messages: {},
}
