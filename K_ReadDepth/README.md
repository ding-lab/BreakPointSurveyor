# ReadDepth

*Evaluate read depth in target regions, and obtain BAM file statistics used for calculating copy number*

* Evaluate read depth (number of reads mapping to a genomic position) in WGS data for regions defined in PlotList.  `depthFilter.py` will subsample
  the depth so that no more than about 10K data points are returned, no matter the region size.
* `flagstat` files, generated with the `samtools` utility, provide a summary of the number of reads in a BAM file.  They are generated if
  they do not already exist (test appending `.flagstat` to BAM filename).
* Create summary table used to obtained copy number.  Copy number at a given
  genomic position is estimated (in `DepthDrawer.R`) as `2 * read_depth / RD`,
  where RD is average read depth across the genome, `RD = num_reads *
  read_length / genome_length`.  `num_reads` is obtained from the BAM file directly.
* Similar statistics are obtained for RNA-Seq BAM files as well, to be used for RPKM calculations.

