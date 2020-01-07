IMAGE="mwyczalkowski/somatic_sv_workflow:20200102"
bsub -Is -q research-hpc -a "docker($IMAGE)" /bin/bash

