# Expression

*Analyze RNA-Seq expression in vicinity of integration events.*

Evaluate the expression of case versus controls, of which there are typically many.

* In L_Expression stage, obtain expression data from RNA-Seq BAMs directly.
* An alternate workflow is illustrated in stage M_RSEM_Expression which uses
  pre-processed RSEM expression data, with no need for sequence (RNA-Seq data)

Either stage is required for BPS expression plots, but not necessary for structure plots.

* For each case, create BED file which indicates regions of interest where RPKM data will be evaluated.
   Regions of interest are all exons belonging to genes within some distance - here, 1Mbp - of integration event.
* Analyze RNA-Seq data for both cases (sample with integration event in given region)
   and controls (all other samples with same cancer type as case) to obtain RPKM, a normalized count of 
   RNA-Seq reads mapped to regions of interest.  Note that this step reads RNA-Seq BED files.
    * Raw RNA-Seq reads are counted for each exon using `bedtools coverage`.
    Per-exon RPKM is evaluated as (10^9 * R)/(N * L), where R is the number of raw
    reads mapped to an exon, N is the count of total mapped reads, and L is exon length.
* Evaluate expression of case exons vs. control. Combine exon expression to obtain per-gene p-value
   which quantifies degree to which gene expression differs in case vs. controls.
   * Specifically, we report the probability that expression of case is drawn from the same distribution as expression
     of controls.
   * See `$BPS_CORE/src/analysis/ExonExpressionAnalyzer.R`
   * [See algorithm details here.](AlgorithmDetails.md)

The third step can work with other expression data, e.g. RSEM data as illustrated in M_RSEM_Expression.

