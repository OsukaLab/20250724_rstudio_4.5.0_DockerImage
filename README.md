# Osuka Lab RStudio Bioinformatics Docker Image

Dockerized RStudio environment for reproducible bioinformatics analyses in the Osuka Lab.

This image is designed for bulk RNA-seq, single-cell RNA-seq, flow cytometry, pathway analysis, survival analysis, and spatial transcriptomics workflows.

## Current Stable Version

**Docker image:** `lsbarr/20250724_rstudio_4.5.0:1.7.0`

**Environment**
- R 4.5.0
- Bioconductor 3.21
- RStudio Server
- Ubuntu 24.04 LTS

Version `1.7.0` is the current recommended environment for new analyses.

Older tagged images are retained for reproducibility.

## Major Analysis Capabilities

### Single-cell RNA-seq
Includes tools for preprocessing, clustering, visualization, trajectory analysis, and cell-cell communication, including:

- Seurat
- BPCells
- SingleCellExperiment
- monocle3
- CellChat
- NicheNet
- ComplexHeatmap
- clusterProfiler
- enrichplot

### Bulk RNA-seq and public datasets

Includes tools for differential expression, TCGA/GEO analysis, pathway enrichment, and clinical analysis, including:

- DESeq2
- limma
- edgeR
- TCGAbiolinks
- GEOquery
- biomaRt
- maftools
- survival
- survminer
- fgsea

### Flow cytometry

Version `1.7.0` adds:

- FlowSOM
- flowCore

These packages support FCS handling, dimensionality reduction workflows, and FlowSOM clustering used in spectral flow cytometry analyses.

### Spatial transcriptomics and Xenium

Version `1.7.0` adds a foundation for 10x Genomics Xenium and other spatial transcriptomics workflows:

- SpatialExperiment
- XeniumIO
- SpatialExperimentIO
- Banksy
- nnSVG
- arrow

Seurat and BPCells are also available for large-scale single-cell and spatial workflows.

## Version History

### v1.7.0

Added:
- FlowSOM
- flowCore
- SpatialExperiment
- XeniumIO
- SpatialExperimentIO
- Banksy
- nnSVG
- arrow

R remains at version 4.5.0 and Bioconductor remains at version 3.21.

No existing package versions from `1.6.1` were upgraded or downgraded during creation of `1.7.0`.

See [`CHANGELOG.md`](CHANGELOG.md) for additional details.

### v1.6.1

Stable R 4.5.0 environment containing the expanded single-cell analysis toolkit, including monocle3, CellChat, NicheNet, clusterProfiler, and enrichplot.

### Earlier versions

Older Docker images are retained for reproducibility of previous analyses.

## Reproducibility Records

Exact installed package versions are recorded under:

```text
environment/
├── v1.6.1/
│   ├── R_packages.csv
│   └── sessionInfo.txt
└── v1.7.0/
    ├── R_packages.csv
    └── sessionInfo.txt
```

`R_packages.csv` records the complete installed R package environment for each release.

`sessionInfo.txt` records the R version, operating system, platform, BLAS/LAPACK configuration, and related runtime information.

## Running Locally with Docker

First make sure Docker Desktop is running.

Pull the image:

```bash
docker pull lsbarr/20250724_rstudio_4.5.0:1.7.0
```

Run RStudio Server:

```bash
docker run --rm \
  -p 127.0.0.1:8787:8787 \
  -v /path/to/data:/Data \
  lsbarr/20250724_rstudio_4.5.0:1.7.0
```

On Windows PowerShell, for example:

```powershell
docker run --rm `
  -p 127.0.0.1:8787:8787 `
  -v "D:\Data:/Data" `
  lsbarr/20250724_rstudio_4.5.0:1.7.0
```

Then open:

```text
http://localhost:8787
```

Default RStudio credentials:

```text
Username: rstudio
Password: rstudio
```

The RStudio port should generally be bound to `127.0.0.1` when running locally so that the server is not exposed directly to the network.

## Building the Image

To build version `1.7.0` locally:

```bash
docker build \
  -f Dockerfile.1.7.0 \
  -t lsbarr/20250724_rstudio_4.5.0:1.7.0 \
  .
```

The `1.7.0` Dockerfile builds directly on the stable `1.6.1` image:

```text
1.6.1
  ↓
Dockerfile.1.7.0
  ↓
1.7.0
```

This allows new capabilities to be added without altering the known-working previous environment.

## Testing a Build

The `1.7.0` Dockerfile includes an installation check that verifies the newly added packages are available.

A manual smoke test can also be run with:

```bash
docker run --rm \
  lsbarr/20250724_rstudio_4.5.0:1.7.0 \
  Rscript -e "library(FlowSOM); library(flowCore); library(SpatialExperiment); library(XeniumIO); library(SpatialExperimentIO); library(Banksy); library(nnSVG); library(arrow); cat('v1.7.0 smoke test passed\n')"
```

Expected final output:

```text
v1.7.0 smoke test passed
```

## Repository Organization

```text
20250724_rstudio_4.5.0_DockerImage/
├── Dockerfile
├── Dockerfile.rstudio
├── Dockerfile.fullpackages
├── Dockerfile.20251001
├── Dockerfile.1.7.0
├── CHANGELOG.md
├── README.md
└── environment/
    ├── v1.6.1/
    │   ├── R_packages.csv
    │   └── sessionInfo.txt
    └── v1.7.0/
        ├── R_packages.csv
        └── sessionInfo.txt
```

Older Dockerfiles are retained to preserve the development history of the environment.

## Versioning

Docker image versions and Git tags are kept synchronized.

For example:

```text
Git tag:      v1.7.0
Docker image: lsbarr/20250724_rstudio_4.5.0:1.7.0
```

A tagged version should represent a tested and reproducible analysis environment.

New development occurs after the most recent stable version and is documented in `CHANGELOG.md`.

## Data and Analysis Files

Large research datasets should **not** be stored in this repository.

Examples include:

- FASTQ files
- BAM files
- `.h5` / `.h5ad` files
- large Seurat `.rds` objects
- Xenium output directories
- count matrices
- large public GEO/TCGA downloads

The Docker image provides the software environment, while analysis repositories should contain project-specific scripts, documentation, figures, and lightweight results.

## HPC / Cheaha

This Docker image is intended to also serve as the reproducible software environment for analyses performed on UAB Cheaha.

On Cheaha, the Docker image will be executed through Apptainer/Singularity rather than Docker directly.

Project-specific code will be maintained in separate GitHub repositories, while large datasets and computationally intensive processing will remain on Cheaha storage.

Detailed Cheaha instructions will be added after the cluster workflow is established.

## Maintainer

Osuka Lab  
University of Alabama at Birmingham