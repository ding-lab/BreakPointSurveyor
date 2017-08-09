# use the ubuntu base image
FROM ubuntu:xenial

# Acknowledgements to Delly: https://raw.githubusercontent.com/dellytools/delly/master/docker/Dockerfile

LABEL author="Matt Wyczalkowski" \
      maintainer="m.wyczalkowski@wustl.edu"

RUN apt-get update && apt-get install -y \
    autoconf \
    bedtools \
    build-essential \
    bwa \
    cpanminus \
    gawk \
    git \
    imagemagick \
    libbz2-dev \ 
    liblzma-dev \
    python \
    python-dev \
    python-pip \
    r-base \
    vim-tiny \
    wget \
    zlib1g-dev \
    && apt-get clean

#  Various R packgages
RUN echo 'install.packages(c("ggplot2", "plyr", "reshape2", "RColorBrewer", "scales", "bitops", "gridExtra", "gridBase", "stringr"), repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R ; \
echo 'source("https://bioconductor.org/biocLite.R"); biocLite("DNAcopy")' >> /tmp/packages.R \
&& Rscript /tmp/packages.R

# Various Python packages
RUN pip install \
    pyvcf \
    pysam \
    numpy

# Perl packags
RUN cpanm XML::XPath

# Installing HTSLIB
RUN cd /usr/local \
    && git clone https://github.com/samtools/htslib.git \
    && cd /usr/local/htslib \
    && make \
    && make lib-static \
    && make install

ENV LD_LIBRARY_PATH=/usr/local/htslib

# Install samtools
RUN cd /usr/local/ \
    && git clone https://github.com/samtools/samtools.git \
    && cd samtools \
    && make \
    && make install
    
# Install Pindel
RUN cd /usr/local/ \
    && git clone --recursive https://github.com/genome/pindel.git  \
    && cd /usr/local/pindel/ \
    && ./INSTALL /usr/local/htslib

# Tigra
# Need to copy Tigra.Makefile.patch to container
# Patching:
#   To make a patch:
#       diff -u Makefile.orig Makefile > Tigra.Makefile.patch
#   To apply a patch:
#       patch Makefile Tigra.Makefile.patch
#

COPY container-init/Tigra.Makefile.patch /usr/local
RUN cd /usr/local \
    && git clone https://bitbucket.org/xianfan/tigra.git \
    && cd tigra \
    && patch Makefile /usr/local/Tigra.Makefile.patch \
    && make \
    && make install

# Novobreak
RUN cd /usr/local \
    && git clone https://git.code.sf.net/p/novobreak/git novobreak-git \
    && cd novobreak-git \
    && make

RUN groupadd -r bps && useradd -r -g bps -m bps

# Finally install Breakpoint Surveyor
RUN cd /usr/local \
    && git clone --recursive https://github.com/ding-lab/BreakPointSurveyor.git \
    && chown -R bps:bps /usr/local/BreakPointSurveyor 

# below places user in BPS path, but not on MGI
WORKDIR /usr/local/BreakPointSurveyor
USER bps

# cd /usr/local/BreakPointSurveyor
# git checkout Synthetic
# ./run_BPS A_Reference/ B_ExonGene/ C_SyntheticBAM/ D_TestBAM/ F_Project/ G_Discordant/ J_PlotList/ K_ReadDepth/ N_DrawBreakpoint/ O_DrawDepth/ P_DrawAnnotation/ Q_DrawHistogram/ T_PlotStructure/

# following invocation will create common data dir in ./
# docker run -v $PWD/data:/data -it breakpoint_surveyor
VOLUME ["/data"]

CMD ["/bin/bash"]
