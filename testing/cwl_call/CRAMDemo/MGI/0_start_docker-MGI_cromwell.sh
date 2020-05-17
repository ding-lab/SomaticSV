# Launch docker environment at MGI before running cromwell.

# currently, using gsub, which tends to point to recent cromwell versions
/gscmnt/gc2560/core/env/v1/bin/gsub -m 8

# An alternative is to use cromwell-runner image, which has an updated version of Cromwell JAR
# See TinDaisy demos
