CWL="../../cwl/somatic_sv_workflow.cwl"
#YAML="project_config.yaml"
YAML="project_config.C3L-00079.yaml"

mkdir -p results
RABIX_ARGS="--basedir results"

rabix $RABIX_ARGS $CWL $YAML

