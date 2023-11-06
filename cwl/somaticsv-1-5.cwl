class: Workflow
cwlVersion: v1.0
id: somaticsv_1_5
label: SomaticSV-1.5
inputs:
  - id: normal
    type: File
  - id: reference
    type: File
  - id: tumor
    type: File
  - id: generateEvidenceBam
    type: boolean?
outputs:
  - id: output_evidence
    outputSource:
      somatic_sv_workflow/output_evidence
    type:
      - 'null'
      - File
      - type: array
        items: File
  - id: bedpe
    outputSource:
      vcftobedpe/bedpe
    type: File
  - id: output
    outputSource:
      somatic_sv_workflow/output
    type: File?
steps:
  - id: somatic_sv_workflow
    in:
      - id: tumor
        source: tumor
      - id: normal
        source: normal
      - id: reference
        source: reference
      - id: generateEvidenceBam
        source: generateEvidenceBam
    out:
      - id: output
      - id: output_evidence
    run: ./SomaticSV.cwl
    label: Somatic_SV_Workflow
  - id: vcftobedpe
    in:
      - id: input
        source: somatic_sv_workflow/output
    out:
      - id: bedpe
    run: ./vcftobedpe.cwl
    label: vcftobedpe
requirements: []
