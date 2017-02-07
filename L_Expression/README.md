# Expression

*Analyze RNA-Seq expression in vicinity of integration events.*

This stage is required for BPS expression plots, but is not needed for structure plots and can
be skipped.  It requires a number of RNA-Seq samples to serve as controls.

1. For each case, create BED file which indicate regions of interest for each disease type
   Regions of interest are all exons belonging to genes within 1Mbp of integration event.
2. Analyze RNA-Seq data for both cases (sample with integration event in given region)
   and controls (all other samples with same cancer type as case) to obtain RPKM, a normalized count of 
   RNA-Seq reads mapped to regions of interest.
3. Evaluate expression of case exons vs. control. Combine exon expression to obtain per-gene p-value
   of degree to which gene expression differs in case vs. controls.


