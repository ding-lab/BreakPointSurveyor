# DrawHistogram

*Create histogram panel GGP showing distribution of read depth*

Histogram displays copy number or read depth for chrom A and B in the regions specified by PlotList.

Here, we demonstrate customization of the histogram by specifying its maximum range.  This is done in the file `Histogram.PlotOpts.special`
by defining,
```
NA19240.AQ.chr10_chr20	50	# hist.max
```

See [`HistogramDrawer.R`](https://github.com/ding-lab/BreakPointSurveyor-Core/blob/master/src/plot/HistogramDrawer.R)
for details.  

See
[N_DrawBreakpoint](https://github.com/ding-lab/BreakPointSurveyor/tree/master/N_DrawBreakpoint)
and the [developer
guide](https://github.com/ding-lab/BreakPointSurveyor/blob/master/Development.md)
for general details about plotting.
