IMAGE="mwyczalkowski/somatic_sv_workflow:20200108"
bsub -Is -q research-hpc -a "docker($IMAGE)" /bin/bash

