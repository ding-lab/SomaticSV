## Somatic SV Workflow

### SV Caller
- Manta 1.2.1

### Filtering
Only select the variants which pass the following criteria:
- Sample site depth is less than 3x the median chromosome depth near one or both variant breakends
- Somatic score is greater than 30
- For a small variant (<1000 bases) in the normal sample, the fraction of reads with MAPQ0 around either breakend doesn't exceed 0.4

### Docker
```bash
docker build -t somatic_sv_workflow docker/
docker run -it somatic_sv_workflow
```
