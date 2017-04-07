# PlotList

*Generate PlotList to define regions for plotting*

The goal of this stage is to generate the PlotList.dat file, which defines
regions of interest for subsequent analysis and plotting; each line of PlotList.dat
will become one figure.  See
[TCGA_Virus](https://github.com/ding-lab/BreakPointSurveyor/blob/master/J_PlotList/README.md)
workflow documentation for more details about PlotList and clustering.

We define a "flank" of 1000bp around the intergration event to focus the structure plot only on this region.
