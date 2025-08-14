FROM bioconductor/bioconductor_docker:RELEASE_3_21-R-4.5.0

# -------------------------------------------------------------------
# 1. Install system dependencies
# -------------------------------------------------------------------
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libcairo2-dev libxt-dev \
    libxml2-dev \
    libudunits2-dev \
    libhdf5-dev \
    libv8-dev \
    libgdal-dev \
    xorg libx11-dev libglu1-mesa-dev \
    samtools libboost-all-dev \
    libgsl-dev \
    wget unzip git && \
    rm -rf /var/lib/apt/lists/*

# -------------------------------------------------------------------
# 2. Make sure BiocManager & remotes are available
# -------------------------------------------------------------------
RUN R -e 'if(!"BiocManager" %in% rownames(installed.packages())) install.packages("BiocManager")'
RUN R -e 'if(!"remotes" %in% rownames(installed.packages())) install.packages("remotes")'

# -------------------------------------------------------------------
# 3. Install core CRAN packages (split in chunks for stability)
# -------------------------------------------------------------------
RUN R -e 'install.packages(c( \
  "dplyr","ggplot2","tidyverse","patchwork","cowplot","data.table","lubridate","fs","here","glue","purrr","stringr","readr","readxl"))'

RUN R -e 'install.packages(c( \
  "rmarkdown","knitr","broom","dbplyr","dtplyr","devtools","cli","pillar","RColorBrewer","viridis","viridisLite"))'

RUN R -e 'install.packages(c( \
  "ggpubr","ggrepel","ggridges","ggthemes","plotly","ComplexHeatmap","EnhancedVolcano","corrplot","circlize"))'

RUN R -e 'install.packages(c( \
  "Seurat","SeuratObject","future","future.apply","hdf5r","RcppAnnoy","uwot","igraph"))'

RUN R -e 'install.packages(c( \
  "survival","survminer","maxstat","lmtest","lme4","pbkrtest","car","carData"))'

# -------------------------------------------------------------------
# 4. Install Bioconductor packages (split in chunks)
# -------------------------------------------------------------------
RUN R -e 'BiocManager::install(c( \
  "SummarizedExperiment","SingleR","AnnotationHub","ExperimentHub","org.Hs.eg.db","org.Mm.eg.db"))'

RUN R -e 'BiocManager::install(c( \
  "GEOquery","celldex","GenomicRanges","IRanges","DelayedArray","MatrixGenerics","GenomeInfoDb"))'

RUN R -e 'BiocManager::install(c( \
  "HDF5Array","Biostrings","BiocParallel","BiocNeighbors","BiocSingular"))'

# -------------------------------------------------------------------
# 5. Default command (start R by default)
# -------------------------------------------------------------------
CMD ["R"]
