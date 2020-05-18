# Project Config file
#
# This file is common to all steps in project
# Contains all per-system configuration
# Contains only definitions, no execution code

# Root directory of SomaticSV
SSV_ROOT="."

# List of cases to analyze
CASES="./dat/cases.dat"

# Path to BamMap, which is a file which defines sequence data path and other metadata
# BamMap format is defined here: https://github.com/ding-lab/importGDC/blob/master/make_bam_map.sh
BAMMAP="dat/BamMap.HNSCC.UMich.dat"

# Workflow output directory - this is where intermediate and final files generated by workflow scripts go
RABIXD="/diskmnt/Projects/cptac_scratch/Rabix"

# Output of task manager
LOGD="./logs"

# This path below is for CPTAC3-standard GRCh38 reference
REF="/home/mwyczalk_test/Projects/RIS/mnt/Active/Resources/References/GRCh38_full_analysis_set_plus_decoy_hla/GRCh38_full_analysis_set_plus_decoy_hla.fa"

YAMLD="./yaml"

CWL="$SSV_ROOT/cwl/SomaticSV.cwl"

PRE_SUMMARY="dat/analysis_pre-summary.dat"
SUMMARY="dat/analysis_summary.dat"
