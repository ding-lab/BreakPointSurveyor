# PlotList

*Generate PlotList to define regions for plotting*

The goal of this stage is to generate the PlotList.dat file, which defines
regions of interest for subsequent analysis and plotting; each line of PlotList.dat
will become one figure.

Provide step-by-step example of how might implement new datasets into PlotList
generation.  Considerations

* May be BPC or BPR - point out 1000SV branch has BPC implementation
  * Change name of steps in these two branches to reflect the BPC/BPR distinction
* May or may not need clustering
  * Synthetic branch just creates the PlotList file de novo
    * Maybe have a script to generate PlotList in Synthetic?

*Identify target regions for further processing and visualization*


*TODO* mention that use FAI in step 3.  Focusing on BPC since doing discordant.

The goal of this stage is to generate the PlotList.dat file, which defines
regions of interest for subsequent analysis and plotting; each line of PlotList.dat
will become one figure.

Defining the PlotList is a critical step for downstream plotting and analysis:
it defines the list of regions for further processing.  In particular, the "range"
defined in PlotList defines the region which will be plotted, in this case the
integration event +/- 5kBP

Here, the regions of interest are defined based on clustering of discordant
reads (even though we know what they are because we generated the data).

Here, the regions of interest are defined based on clustering of discordant
reads (even though we know what they are because we generated the data).

Note that you already know the regions of interest, the steps in this directory can be skipped,
and edit `dat/PlotList.dat` manually to define them.

We choose to include an additional 1Kbps "padding" around the integration event; this will be
the region of the BPS structure plot 

Note, step 3 requires an FAI file, which is generally provided with the reference.

PlotList is TSV format with the following columns,

* barcode
* event.name (unique)
* chrom.a, (first chromosome of coordinate pair)
* event.a.start, event.a.end (indicates region of e.g. SV event)
* range.a.start, range.a.end (indicates region to plot; calculated as event.start - context, event.end + context, respectively)
* chrom.b, (second chromosome of coordiante pair)
* event.b.start, event.b.end, range.b.start, range.b.end 

