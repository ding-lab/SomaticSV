# Generate cromwell config file

CONFIG_TEMPLATE="cromwell-config-db.template.dat"
CONFIG_FILE="dat/cromwell-config-db.dat"
WORKFLOW_ROOT="/gscmnt/gc2619/dinglab_cptac3"

>&2 echo Writing Cromwell config file to $CONFIG_FILE
>&2 echo Workflow output will be written to $WORKFLOW_ROOT

mkdir -p $(dirname $CONFIG_FILE)
src/make_config.sh $CONFIG_TEMPLATE $WORKFLOW_ROOT > $CONFIG_FILE
