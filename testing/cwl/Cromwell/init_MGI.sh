# launch docker environment at MGI to use for Cromwell submissions
# this must be run prior to run_cromwell.sh
 
IMAGE="registry.gsc.wustl.edu/apipe-builder/genome_perl_environment:5"
bsub -Is -q research-hpc -a "docker($IMAGE)" /bin/bash
