# work from latest LTS ubuntu release
FROM ubuntu:18.04

# set variables
ENV r_version 3.6.0

# run update
RUN apt-get update -y && apt-get install -y \
  gfortran \
  libreadline-dev \
  libpcre3-dev \
  libcurl4-openssl-dev \
  build-essential \
  zlib1g-dev \
  libbz2-dev \
  liblzma-dev \
  openjdk-8-jdk \
  wget \
  libssl-dev \
  libxml2-dev \
  libnss-sss

# change working dir
WORKDIR /usr/local/bin

# install R
RUN wget https://cran.r-project.org/src/base/R-3/R-${r_version}.tar.gz
RUN tar -zxvf R-${r_version}.tar.gz
WORKDIR /usr/local/bin/R-${r_version}
RUN ./configure --prefix=/usr/local/ --with-x=no
RUN make
RUN make install

# install R packages
RUN R --vanilla -e 'install.packages(c("devtools", "BiocManager","Seurat"), repos="http://cran.us.r-project.org")'
RUN R --vanilla -e 'BiocManager::install(c("biomaRt", "copynumber", "GenVisR", "fgsea", "deseq2", "EBSeq", "BSgenome.Hsapiens.UCSC.hg19", "BSgenome.Hsapiens.UCSC.hg38", "TxDb.Hsapiens.UCSC.hg19.knownGene", "TxDb.Hsapiens.UCSC.hg38.knownGene", "org.Hs.eg.db"))'
RUN R --vanilla -e 'install.packages(c("ggplot2", "data.table", "sequenza", "dplyr", "reshape2", "tidyr", "viridis", "cowplot", "ggalluvial", "msigdbr", "ggdendro", "gridExtra", "deconstructSigs","splitstackshape"), repos = "http://cran.us.r-project.org")'
