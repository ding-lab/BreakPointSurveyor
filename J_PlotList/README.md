# PlotList

`dat/PlotList.dat` defines integration event and regions of interest.

The goal of this stage is to generate the PlotList.dat file, a key step for
downstream plotting and analysis.  Each line of `PlotList.dat` will generally
yield one structure plot and one expresssion plot figure.

## PlotList File Format

`PlotList.dat` is a tab separated (TSV) format with the columns,

* `barcode`
* `event.name` (unique)
* `chrom.a` (first chromosome of coordinate pair)
* `event.a.start, event.a.end` (indicates region of e.g. SV event)
* `range.a.start, range.a.end` 
* `chrom.b`, (second chromosome of coordiante pair)
* `event.b.start, event.b.end, range.b.start, range.b.end`

The `event` positions identify the predicted integration event.  The `range` positions
define a region of interest around the integration event which will be used for plotting
of structure plots. (This region is not used for expression plots).  The "padding" around
the integration event to the `context`:
```
range.a.start = event.start - context 
range.a.end = event.end + context
```

## Clustering

To automatically generate regions of interest, we group multiple nearby breakpoints on the same chromosome pair into clusters
to serve as preliminary integration event predictions.

With each breakpoint between chromA and chromB represented by a point with
coordinates (posA, posB), the clustering algorithm draws a square with sides
length L/2 centered at each breakpoint, and all breakpoints within overlapping
squares are grouped into one cluster.  Details in
[makeBreakpointRegions.py](https://github.com/ding-lab/BreakPointSurveyor-Core/blob/master/src/util/makeBreakpointRegions.py).

### TCGA_Virus
Nearby Pindel breakpoints between the same chromosome and virus (those
occurring within 50Kbp of one another along both genomes) were clustered into
integration events, which defined regions of interest for all subsequent
analyses.  Note that for the sample of interest all three breakpoints were
nearby.

We include an additional 50Kbps "padding" around the integration event to include in structure plot.
Note that expression analysis uses integration event positions from `PlotList`, but 
includes a larger domain to identify genes of interest for that analysis.

## Getting started

If regions of interest for downstream analysis are known, clustering and
prioritization is not necessary.  A simple approach then is to create a BPR
file to define regions of interest to be used as input into
`3_make_PlotList.sh`, which will calculate the range values.

Clustering of discordant reads to prioritize regions of interest is demonstrated in the
1000SV workflow.

