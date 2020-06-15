# Somatic SV Workflow
With modifications for CWL integration

Contact Matt Wyczalkowski (m.wyczalkowski@wustl.edu) with questions


## SV Caller
- Manta 1.4.0
- Filters: Only select the variants which pass the following criteria:
    - Sample site depth is less than 3x the median chromosome depth near one or both variant breakends
    - Somatic score is greater than 30
    - For a small variant (<1000 bases) in the normal sample, the fraction of reads with MAPQ0 around either breakend doesn't exceed 0.4

## Cromwell updates

Starting in January 2020 (cromwell branch) SomaticSV workflow is being run on Cromwell using CromwellRunner.
Consequently, the simple workflow management under Rabix described below is being phased out, and this project
is principally to develop and test the docker image 

# Run Notes

There are a number of ways to run SomaticSV workflow, as discussed in Development Notes below.  
In general, starting May 2020, SomaticSV is run using [CromwellRunner](https://github.com/ding-lab/CromwellRunner.git)

Install [SomaticSV](https://github.com/ding-lab/SomaticSV.git)
```
git clone --recurse-submodules https://github.com/ding-lab/SomaticSV.git
```

May need to get docker/WUDocker submodule:
```
git submodule init
git submodule update
```

# Development notes
## Demo data

For development and testing purposes, we distribute Demo data obtained from [Manta distribution](https://github.com/Illumina/manta/tree/master/src/demo/data)
in `demo/demo_data` directory, consisting of small tumor/normal BAM files and a reference.  Prior to testing, need to uncompress
the reference with,
```
tar -xvjf Homo_sapiens_assembly19.COST16011_region.fa.tar.bz2
```

## Demo projects
`./demo` directory contains example runs with the workflow executed directly (i.e., inside docker container), by calling docker, and by calling CWL (Rabix and Cromwell).



