# Remove sbg-specific tags from workflow CWL
# usage:
#   removeSBG.sh workflow.cwl 
#
# Removes SBG-specific tags from CWL
# writes to same filename
# writes original to CWL.orig

# In addition:
#  Cromwell will not run on workflows directly from Composer and need to be edited slightly.
#  This has to do with removing `-` symbol in the workflow CWL file: change something like
#```
#outputs:
#   - id: output_maf
#     outputSource:
#       - vcf_2_maf/output_maf
#```
#to
#```
#outputs:
#  - id: output_maf
#      outputSource:
#        vcf_2_maf/output_maf
#```


CWL=$1
if [ ! -e $CWL ]; then
    >&2 echo ERROR: pass CWL filename
    exit 1
fi

CWL_ORIG="${CWL}.orig"
mv $CWL $CWL_ORIG

rc=$?
if [[ $rc != 0 ]]; then
    >&2 echo Fatal ERROR $rc: $!.  Exiting.
    exit $rc;
fi

grep -v "sbg:" $CWL_ORIG | grep -v "\$namespaces:" > $CWL

>&2 echo SBG tags removed from $CWL
>&2 echo Original written to $CWL_ORIG
