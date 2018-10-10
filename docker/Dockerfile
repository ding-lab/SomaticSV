FROM biocontainers/biocontainers:latest

LABEL base.image="biocontainers:latest"
LABEL version="1"
LABEL software="Somatic SV Workflow"
LABEL software.version="0.3"
LABEL description="Somatic SV workflow"
LABEL website="https://github.com/ding-lab/somatic_sv_workflow"
LABEL documentation="https://github.com/ding-lab/somatic_sv_workflow/blob/master/README.md"
LABEL license="https://github.com/ding-lab/somatic_sv_workflow/blob/master/LICENSE"
LABEL tags="Genomics"

MAINTAINER Wen-Wei Liao <wen-wei.liao@wustl.edu>
MAINTAINER Matthew Wyczalkowski <m.wyczalkowski@wustl.edu>

RUN conda install -y manta cyvcf2

WORKDIR /home/biodocker

RUN cd /usr/local \
    && git clone https://github.com/mwyczalkowski/somatic_sv_workflow.git

COPY vimrc /root/.vimrc
USER root
