# PlotList

*Identify target regions for further processing and visualization*


*TODO* mention that use FAI in step 3.  Focusing on BPC since doing discordant.

Defining the PlotList is a critical step for downstream plotting and analysis:
it defines the list of regions for further processing.  In particular, the "range"
defined in PlotList defines the region which will be plotted, in this case the
integration event +/- 50kBP

PlotList can be defined based on any breakpoint prediction algorithm; here, it
is based on Pinel predictions, though it could also be created from Discordant Reads
or any other BPC or BPR file.  To keep the list of regions a manageable size for 
techniques which have high false positive rates, we prioritize those regions which
have the most breakpoint predictions.

Steps `x.1_` and `x.2_` cluster discordant reads and prioritize the clusters.  This analysis
is not used for PlotList generation, but serves as a reference for parsing BPC breakpoint
predictions.

Once the PlotList is defined here automatically, it can be manually modified before
further processing.

PlotList is TSV format with the following columns,

* barcode
* event.name (unique)
* chrom.a, (first chromosome of coordinate pair)
* event.a.start, event.a.end (indicates region of e.g. SV event)
* range.a.start, range.a.end (indicates region to plot; calculated as event.start - context, event.end + context, respectively)
* chrom.b, (second chromosome of coordiante pair)
* event.b.start, event.b.end, range.b.start, range.b.end 

A PlotList file lists all SV events which are to be plotted, with one plot per line.
For SVs, we have the positions of the event on Chrom A and B, as well as the "range" for
both chromosomes.  The range sets the limits of BPS structure plots.
