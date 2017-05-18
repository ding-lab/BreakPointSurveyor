# AssembleBPS

*Assemble GGP panels into BPS structure plot and save as PDF and PNG files*

All GGP panels required for the structure plot are aligned and assembled into
a composite figure and saved as PDF.  The PDF is then converted to a PNG file.

See [TCGA_Virus workflow](https://github.com/ding-lab/BreakPointSurveyor/blob/master/T_PlotStructure/README.md) for interpretation of structure plots.

### AQ Event

The "AQ" event occurs between genomic regions chr10:41854249-41915847 and chr20:31051980-31241883.

<img src="plots/NA19240.AQ.chr10_chr20.BreakpointSurvey.png" width="600"/>

AQ event has a discordant read signature which is frequently observed: no
correlation between discordant read positions on the two chromosomes and a
spike in copy number.  This likely represents anomalous mapping between two
repetitive regions.

### AU Event

"AU" event occurs between genomic regions chr13:62947705-63061713 and chr17:221247350-22180085.

<img src="plots/NA19240.AU.chr13_chr17.BreakpointSurvey.png" width="600"/>

This event has a very different discordant read pattern than AQ, with the reads falling cleanly on a diagonal.  
This event is likely to be a tandem duplication.  The discordant reads on Chr13 fall on “gene” RP11-527N12.2,
which [is consistent with this interpretation](https://www.biostars.org/p/51456/).

The BPS Structure plots of events AQ and AU clearly illustrate how visualizing discordant reads as coordinates 
on a plane yields patterns and interpretations which would not be discernable in other representations.

For comparison, see [Circos](http://circos.ca) plots of of events [AQ](../doc/NA19240-AQ.png) and [AU](../doc/NA19240-AU.png).

