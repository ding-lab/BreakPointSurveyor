# Project
*Create list of BAMs, both realigned WGS and RNA-Seq.*

Constructing a "minimal" BAM to demonstrate events.

Create here TCGA_Virus.SampleList.dat, which contains the following fields for each sample of interest,
* Barcode - unique identifier
* disease - TCGA code of cancer type
* BAM_path - path to BAM file realigned to human + virus reference
* REF_path - path to reference FASTA the BAM is aligned to

For BPS.TCGA_Virus.Lite, we will focus on one sample only,
* TCGA HNSC WGS barcode TCGA-BA-4077-01B-01D-2268-08
    * CGHub analysis_id 21d62291-2267-463c-b395-367efad4985e, 
      [available here](https://gdc-portal.nci.nih.gov/legacy-archive/files/6533e56c-b5b8-4c85-862b-a5526c5c2e0a).
* This sample has been realigned to a custom reference.  See manuscript for details 
    * (**TODO**) flesh this out
    * Reference not distributed, but see XXX for how it is generated
* 480+ RNA-Seq samples also downloaded for expression analysis.
* Neither downloaded nor realigned BAMs are distributed with BPS.TCGA_Virus.Lite
