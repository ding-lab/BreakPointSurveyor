# Project
*Create list of BAMs, both realigned WGS and RNA-Seq.*

## Sample information

Scripts here create `dat/BPS.samples.dat` and `dat/BPS.expression.samples.dat`, which contains
the following columns for each sample used for processing related to the
Structure and Expression plots, respectively.

* Barcode - any unique identifier
* disease - TCGA code of cancer type.  Used only in TCGA_Virus workflow
* BAM_path - full path to BAM file realigned to human + virus reference
* REF_path - path to reference FASTA the BAM is aligned to.  Expect to see index file by appending `.fai` to pathname.

## TCGA_Virus workflow

Neither downloaded nor realigned BAMs are distributed with BreakPointSurveyor.

### WGS Data

Analysis considers one sample only, a TCGA head and neck tumor sample with the barcode
([TCGA-BA-4077-01B-01D-2268-08](https://gdc-portal.nci.nih.gov/legacy-archive/files/6533e56c-b5b8-4c85-862b-a5526c5c2e0a))

This sample has been realigned to a custom reference (see [A_Reference](../A_Reference/README.md) for details.)

### RNA-Seq Data

480+ RNA-Seq samples which serve as controls for calulating case relative expression are listed in 
`BPS.expression.samples.dat`.  These data are required for stage L_Expression.

Note that large RNA-Seq datasets need not be downloaded.  See [M_RSEM_Expression](M_RSEM_Expression/README.md) for an
example of expression analysis using TCGA preprocessed expression data.

## Getting started

Edit and run `1_get_BAM_paths.sh` to include information about sequence data used for creating structure plots.  

If calculating RPKM data from RNA-Seq data, edit `2_make_RNASeq_paths.sh` accordingly.

