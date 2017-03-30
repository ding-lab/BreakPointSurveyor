# Expression

*Analyze RNA-Seq expression in vicinity of integration events.*


This stage is required for BPS expression plots, but is not needed for structure plots and can
be skipped.  It requires a number of RNA-Seq samples to serve as controls.

A. For each case, create BED file which indicates regions of interest where RPKM data will be evaluated.
   Regions of interest are all exons belonging to genes within some distance - here, 1Mbp - of integration event.
B. Analyze RNA-Seq data for both cases (sample with integration event in given region)
   and controls (all other samples with same cancer type as case) to obtain RPKM, a normalized count of 
   RNA-Seq reads mapped to regions of interest.  
C. Evaluate expression of case exons vs. control. Combine exon expression to obtain per-gene p-value
   which quantifies degree to which gene expression differs in case vs. controls.
   - Specifically, we report the probability that expression of case is drawn from the same distribution as expression
     of controls.
   - see `$BPS_CORE/src/analysis/ExonExpressionAnalyzer.R`

Note that algorithm in step C can work with other expression data such as TCGA RSEM data.  Example of that analysis provided
in M_RSEM_Expression.


[See algorithm details here.](AlgorithmDetails.md)
