Starting runs for all remaining CPTAC3 LSCC - batch LSCC.20191112

List of all cases to process obtained from shiso:/Users/mwyczalk/Projects/CPTAC3/CPTAC3.Cases/20191105.LSCC/dat/LSCC.WGS.not_processed_case.dat
Consists of 85 WGS LSCC cases not analyzed before. Saved to ./dat/LSCC.WGS.not_processed_case.dat


Processing steps

* Create ./dat/cases.dat
* Edit project_config.sh
  *  Here, CASES="./dat/LSCC.WGS.not_processed_case.dat"

* Test YAML file creation with,
    bash 1_make_yaml.sh -1
  This will process once case and stop.  Examine YAML file closely, confirming paths and BAM file attributes
* Create all YAML files with,
    bash 1_make_yaml.sh 

* Inspect one job command
    bash 2_run_tasks.sh -1d
* Optionally, run one job to test
    bash 2_run_tasks.sh -1

* Optionally start tmux session 
*  -> currently, running on kobuk

* Start five jobs at a time
    bash 2_run_tasks.sh -J 5



# OLD from Y2.B2 below

CPTAC3 Y2.b2 runs

Y2.b2.b differs from Y2.b2 only in that the latter was run on only one case (for testing)
Here, deleting first line from cases.dat, and running the remainder with -J 4

Cohort consists of:
     17 GBM
     77 PDA
     39 UCEC

dat/cases.dat created with,

grep "Y2.b2" /diskmnt/Projects/cptac_scratch/CPTAC3.workflow/CPTAC3.catalog/CPTAC3.cases.dat | cut -f 1 > dat/cases.dat

Example run:
2_run_tasks.sh -J 4

The following cases (3/132) exited with an error and must be restarted.  They are listed in dat/cases.3.dat
C3N-01166
C3N-01830
C3L-00189

Restarting again with these 3; the former to keep everything together, the latter because it died with "null" as output
C3L-00016
C3N-01165
