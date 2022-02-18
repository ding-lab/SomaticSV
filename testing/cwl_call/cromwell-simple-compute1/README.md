This is a template for running `FFPE_Filter` using [Cromwell](https://cromwell.readthedocs.io/en/stable/) on compute1 system at Wash U.

Specifically, testing FFPE Filter on 

# Setup

## WORKFLOW_ROOT
Prior to running, be sure to update the Cromwell configuration to point to an appropirate work directory, which will
typically be different for each user.  As an example, for user `m.wyczalkowski`, the destination directory may be,
    WORKFLOW_ROOT="/scratch1/fs1/dinglab/m.wyczalkowski/cromwell-data"

Specifically,
* Create `$WORKFLOW_ROOT` if it does not exist
    * Also create `$WORKFLOW_ROOT/logs`
* `cp dat/cromwell-config-db.compute1.template.dat dat/cromwell-config-db.compute1.dat`
* Edit `dat/cromwell-config-db.compute1.dat` to replace all instances of the string WORKFLOW_ROOT with the 
  appropriate value

# Starting

* `bash 0_start_docker-compute1_cromwell.sh`
* `cd testing/cromwell-simple-compute1`
* `bash 1_run_cromwell_demo.sh`

