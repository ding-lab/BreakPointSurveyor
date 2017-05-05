# Project

*Create list of sample WGS BAMs and references*

## Sample information

Scripts here create `dat/BPS.samples.dat`, which contains the following columns
for each sample used for processing related to the Structure plots.

* Barcode - any unique identifier
* disease - TCGA code of cancer type.  Used only in TCGA_Virus workflow
* BAM_path - full path to BAM file realigned to human + virus reference
* REF_path - path to reference FASTA the BAM is aligned to.  Expect to see index file by appending `.fai` to pathname.

Illumina 80X sequence data for sample NA19240 is 65Gb in size and can be downloaded from,

`ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/hgsv_sv_discovery/data/YRI/NA19240/high_cov_alignment/NA19240.alt_bwamem_GRCh38DH.20150715.YRI.high_coverage.cram`

We assume this dataset is locally available with a path defined by `BAM_ORIG` variable in `bps.config`.

## Regions of interest

We will focus analysis on the following regions of interest:

### AQ event
```
chr10 41804249 41965847 AQa
chr20 31001980 31291883 AQb
```

### AU event
```
chr13 62897705 63111713 AUa
chr17 22074735 22230085 AUb
```

## Processing

* `1_make_ROI_BED.sh`: Define regions of interest
* `2_make_ROI_BAM.sh`: Extract reads from entire NA19240 dataset.  
* `3_merge_ROI_BAM.sh`: Create two BAM files, one for AQ and one for AU.
* `4_make_BAM_paths.sh`: Define locations of BAM and reference files (the latter also defines path to .fai index file).

Steps 1-3 are optional.  They are used to create a smaller BAM file to make downstream analysis faster.
If you wish to analyze an entire sequence file, simply edit and run `4_make_BAM_paths.sh` with the location of the BAM file(s) to generate `dat/BPS.samples.dat`.

