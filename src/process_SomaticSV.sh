#!/bin/bash

# Matthew Wyczalkowski <m.wyczalkowski@wustl.edu>
# https://dinglab.wustl.edu/

function test_exit_status {
    # Evaluate return value for chain of pipes; see https://stackoverflow.com/questions/90418/exit-shell-script-based-on-process-exit-code
    rcs=${PIPESTATUS[*]};
    for rc in ${rcs}; do
        if [[ $rc != 0 ]]; then
            >&2 echo Fatal error.  Exiting.
            exit $rc;
        fi;
    done
}

function run_cmd {
    CMD=$1

    NOW=$(date)
    if [ "$DRYRUN" == "d" ]; then
        >&2 echo [ $NOW ] Dryrun: $CMD
    else
        >&2 echo [ $NOW ] Running: $CMD
        eval $CMD
        test_exit_status
    fi
}

function confirm {
    FN=$1
    WARN=$2
    NOW=$(date)
    if [ ! -s $FN ]; then
        if [ -z $WARN ]; then
            >&2 echo [ $NOW ] ERROR: $FN does not exist or is empty
            exit 1
        else
            >&2 echo [ $NOW ] WARNING: $FN does not exist or is empty.  Continuing
        fi
    fi
}

read -r -d '' USAGE <<'EOF'
Run Manta SV caller, either tumor/normal or tumor-only modes

Usage: process_SomaticSV.sh [options] tumor.bam reference.fa 

Options [ defaults ]:
-v : verbose output
-d : Dry run - output commands but do not execute them
-o out_dir : Output directory [ ./output ]
-t tumor : tumor BAM filename.  Required
-n normal : normal BAM filename.  Optional
-r reference : reference filename.  Required
-c cpu : CPU count [ 4 ]
# -f output.vcf : specify output filename in manta results dir [ final.SV.WGS.vcf ]
-C CONFIG_ARGS : pass CONFIG_ARGS to configManta.py
-R RUN_ARGS : pass CONFIG_ARGS to runWorkflow.py
EOF

PYTHON="/usr/bin/python"
MANTAD="/opt/conda/bin"

# Set defaults
OUTD="./output"
#OUTVCF="final.SV.WGS.vcf"
CPU="4"

# http://wiki.bash-hackers.org/howto/getopts_tutorial
while getopts ":hvdo:c:C:R:t:n:r:" opt; do
  case $opt in
    h)
      echo "$USAGE"
      exit 0
      ;;
    v)  # binary argument
      VERBOSE=1
      >&2 echo "Verbose output"
      ;;
    d)  # binary argument
      DRYRUN=1
      ;;
    o) # value argument
      OUTD=$OPTARG
      >&2 echo "Output directory: $OUTD "
      ;;
    c) # value argument
      CPU=$OPTARG
      >&2 echo "CPU: $CPU "
      ;;
#    f) # value argument
#      OUTVCF=$OPTARG
#      >&2 echo "Output VCF filename: $OUTVCF "
#      ;;
    C) # value argument
      CONFIG_ARGS="$OPTARG"
    >&2 echo DEBUG: CONFIG_ARGS = $CONFIG_ARGS
      ;;
    R) # value argument
      RUN_ARGS="$OPTARG"
      ;;
    t) # value argument
      TUMOR="$OPTARG"
      confirm $TUMOR
      ;;
    n) # value argument
      NORMAL="$OPTARG"
      confirm $NORMAL
      ;;
    r) # value argument
      REF="$OPTARG"
      confirm $REF
      ;;
    \?)
      >&2 echo "Invalid option: -$OPTARG"
      >&2 echo "$USAGE"
      exit 1
      ;;
    :)
      >&2 echo "Option -$OPTARG requires an argument."
      >&2 echo "$USAGE"
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

if [ ! -e $TUMOR ]; then
    >&2 echo Error: tumor does not exist: $TUMOR
    exit 1
fi
if [ ! -z $NORMAL ]; then
    if [ ! -e $NORMAL ]; then
        >&2 echo Error: normal does not exist: $NORMAL
        exit 1
    fi
fi
if [ ! -e $REF ]; then
    >&2 echo Error: reference does not exist: $REF
    exit 1
fi

# First configure manta
if [ -z $NORMAL ]; then
    CMD="$PYTHON $MANTAD/configManta.py --tumorBam $TUMOR --referenceFasta $REF --runDir $OUTD $CONFIG_ARGS"
else
    CMD="$PYTHON $MANTAD/configManta.py --tumorBam $TUMOR --normalBam $NORMAL --referenceFasta $REF --runDir $OUTD $CONFIG_ARGS"
fi
run_cmd "$CMD"
>&2 echo configManta.py success.

# now run manta
CMD="$PYTHON $OUTD/runWorkflow.py -m local -j $CPU $RUN_ARGS"
run_cmd "$CMD"
>&2 echo runWorkflow.py success.

