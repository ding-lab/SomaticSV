# Run CWL Somatic SV Workflow using Rabix Executor
# Usage:
# bash run_rabix.sh YAML
#
# YAML is input file which defines all arguments to workflow
#
# Output will be in ./results directory

if [ "$#" -ne 1 ]; then
    >&2 echo Error: Wrong number of arguments
    exit 1
fi

YAML=$1
CWL="../../cwl/somatic_sv_workflow.cwl"

mkdir -p results
RABIX_ARGS="--basedir results"

rabix $RABIX_ARGS $CWL $YAML

