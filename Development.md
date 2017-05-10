# BreakPointSurveyor Developer's Guide

## Figure generation

The structure plot is generated using the [ggplot2](http://ggplot2.org/)
package in three steps: 
* data processing
* panel drawing
* figure assembly
The expression plot process is similar, but consists of only one panel without an assembly step.

The data processing step normalizes data into standard formats. For instance,
breakpoint predictions from different SV callers are normalized into a [BPC
file format](#bpc), while read depth and gene annotation are converted to
[Depth](#depth) and
[BED](http://bedtools.readthedocs.io/en/latest/content/general-usage.html)
formats, respectively.  Each dataset is rendered as an image panel using the
`ggplot()` function and saved as a binary [GGP object](#ggp) with `saveRDS()`.
GGP objects can be visualized using the [`ggp2pdf`](#ggp) utility.  

Additional layers, (e.g., predictions from different SV callers), may be added
to an existing GGP object in a subsequent processing step with data from a
different BPC (or BPR) file. 

Finally, multiple GGP objects are assembled, aligned to common axes, and saved
to a PDF format during figure assembly to form a composite figure.  Such
delegation of tasks facilitates incorporation of additional tools and analyses
into the workflow without modifications to the core apps.

See the documentation in [N_DrawBreakpoint](N_DrawBreakpoint/README.md) for additional
details.

## Job Management 
Time consuming steps are designed to be run using cluster job management (e.g., bsub) 
Reference implementation of such scripts: [discordant read analysis](../G_Discordant/1_get_Discordant_reads.sh)


## File Formats

### BPC and BPR file formats <a name="bpc"></a>

We represent breakpoints as a coordinate given by a pair of
chromosome names and positions (breakpoint coordinates, or BPC).  

Similarly, a breakpoint region (BPR), has a pair of chromosome, start, and end values.

BPC and BPR files may optionaly have a final "attributes" column.  This is a
text field whose interpretation is application-specific. For instance, the BPC
attribute column may code for the color of a point plotted at the given
coordinates.  The `1000SV` branch implements attributes to identify read mapping direction
and illustrate multi-chromosome breakpoints.

Each breakpoint coordinate or region is represented just once, with chromA <
chromB (or posA < posB if chromA==chromB), in a tab-separated (TSV) format:
```
       BPC: chromA  posA  chromB  posB  [attribute]
       BPR: chromA  posA.start  posA.end  chromB  posB.start  posB.end  [attribute]
```

BPC and BPR files have no headers.  Lines starting with # are ignored.


### Depth file format <a name="depth"></a>

The "Depth" format is a TSV file having columns chrom, pos, and depth as columns and is identical to the output of `samtools depth`(Li et al., 2009). 

### GGP file format <a name="ggp"></a>

A GGP file is a ggplot object (i.e., output of `ggplot()` in
[GGPlot](http://ggplot2.org/) package), saved in binary format.  

Use the utility `ggp2pdf` to convert GGP to PDF:

```bps-core/src/plot/ggp2pdf test.ggp test.pdf``` 

Continue:

Supplemental figures - get rid of multi panels
Get legends working

Finish response

Every J_PlotList should have a description of clustering methodology
