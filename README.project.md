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
