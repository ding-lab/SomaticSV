class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: vcftobedpe
baseCommand:
  - /opt/hall-lab/python-2.7.15/bin/svtools
  - vcftobedpe
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '-i'
    doc: input VCF
outputs:
  - id: bedpe
    type: File
    outputBinding:
      glob: results/final.SV.WGS.bedpe
label: vcftobedpe
arguments:
  - position: 0
    prefix: '-o'
    valueFrom: results/final.SV.WGS.bedpe
requirements:
  - class: DockerRequirement
    dockerPull: 'halllab/svtools:v0.5.1'
