class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: somatic_sv_workflow
baseCommand:
  - bash
  - /usr/local/somatic_sv_workflow/process_sample.sh
inputs:
  - id: tumor
    type: File
    inputBinding:
      position: 1
    label: Tumor BAM
    secondaryFiles:
      - .bai
  - id: normal
    type: File
    inputBinding:
      position: 2
    label: Normal BAM
    secondaryFiles:
      - .bai
  - id: reference
    type: File
    inputBinding:
      position: 3
    label: Reference FASTA
    secondaryFiles:
      - .fai
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: output/results/variants/final.SV.WGS.vcf
label: Somatic_SV_Workflow
requirements:
  - class: DockerRequirement
    dockerPull: mwyczalkowski/somatic_sv_workflow
