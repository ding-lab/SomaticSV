# Testing of cromwell at MGI

New round of development (circa early 2020) based on TinDaisy work https://github.com/ding-lab/TinDaisy

## Describe what MutectDemo data is

Before running, be sure to uncompress reference in `../demo_data/MutectDemo-data` with
    tar -xvjf Homo_sapiens_assembly19.COST16011_region.fa.tar.bz2


# DEMO
1. `bash 0_start_docker-MGI_cromwell.sh`
2. `bash 1_make_config.sh`
3. edit `2_run_cromwell.sh`, modify `SSW_ROOT` parameter to point to base directory of `somatic_sv_workflow` project
4. `bash 2_run_cromwell.sh`




# C3L-00001 run
Note that C3L-00001 BAMs are stored on gc2619
As above, but with
2. `bash make_config.sh /gscmnt/gc2619/dinglab_cptac3/cromwell-workdir > config/cromwell_config.dat`
3. `bash run_cromwell.sh -c config/cromwell_config.dat ../C3L-00001.MGI.yaml"
