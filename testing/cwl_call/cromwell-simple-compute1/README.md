This is a template for running `SomaticSV` using [Cromwell](https://cromwell.readthedocs.io/en/stable/) on compute1 system at Wash U.

Test scripts:
* `1_run_cromwell-tumor_normal_demo.sh` - run SomaticSV2 with tumor / normal mode
* `2_run_cromwell-tumor_only_demo.sh` - run SomaticSV2 with tumor-only mode
* `3_run_cromwell-somatic_sv_workflow.sh` - run SomaticSV (v1.2), tumor/normal mode

# WORKFLOW_ROOT
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
* `bash 1_run_cromwell-tumor_normal_demo.sh`

