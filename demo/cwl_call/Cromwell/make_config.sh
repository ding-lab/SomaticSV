# Create cromwell configuration file
# Usage:
#   bash make_config.sh OUTROOT

# Based on sample config file here:
# From https://confluence.ris.wustl.edu/pages/viewpage.action?spaceKey=CI&title=Cromwell

# location to write error output logs from individual tools:
#   OUTROOT/logs/cromwell-%J.err
# location for Cromwell's main working directory (temp, intermediate, and final files will all be stored here)
#   OUTROOT/cromwell-executions
# location to write Cromwell's workflow logs
#   OUTROOT/cromwell-workflow-logs

# Having OUTROOT on same filesystem as BAMs allows for hard links and is much faster.  
# Sample OUTROOT: /gscmnt/gc2741/ding/cptac/cromwell-workdir


if [ "$#" -ne 1 ]; then
    >&2 echo Error: Wrong number of arguments
    exit 1
fi

TEMPLATE="cromwell_config.template"
OUTROOT=$1
>&2 echo Creating $OUTROOT/logs
mkdir -p $OUTROOT/logs

rc=$?
if [[ $rc != 0 ]]; then
    >&2 echo Fatal error $rc: $!.  Exiting.
    exit $rc;
fi

# This is printed to STDOUT
sed "s|OUTROOT|$OUTROOT|g" $TEMPLATE 
