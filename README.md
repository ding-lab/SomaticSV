## Somatic SV Workflow

### SV Caller
- Manta 1.2.1

### Filtering Variants
Only select the variants which pass the following criteria:
- Sample site depth is less than 3x the median chromosome depth near one or both variant breakends
- Somatic score is greater than 30
- For a small variant (<1000 bases) in the normal sample, the fraction of reads with MAPQ0 around either breakend doesn't exceed 0.4

### Running Workflow with Docker

1. Pull the docker image

```
docker pull wwliao/somatic_sv_workflow
```

2. Run Manta in the docker container

```
docker run -v /path/to/workspace:/mnt/data wwliao/somatic_sv_workflow manta patient_1.tumor.bam patient_1.normal.bam hg19.fa patient_1 8
```
