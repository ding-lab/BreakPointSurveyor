# ReadDepth

*Evaluate read depth in target regions*

* Evaluate read depth (number of reads mapping to a genomic position) in WGS data for regions defined in PlotList.  `depthFilter.py` will subsample
  the depth so that no more than about 10K data points are returned, no matter the region size.

Copy number estimation performed in the [TCGA_Virus workflow](https://github.com/ding-lab/BreakPointSurveyor/blob/master/K_ReadDepth/README.md) is not 
valid for the small BAM file constructed in C_Project, so we skip the flagstat calculations described for TCGA_Virus.
