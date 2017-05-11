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

## Adding new tools

Breakpoint Surveyor is designed to easily accommodate and visualize a variety of breakpoint prediction tools.
The general procedure for adding a new tool is as follows,
* Prepare and run a new tool in a new stage.  Breakpoint predictions may be output as VCF files with a pair of chromosome names 
and positions, or to BPC/BPR format directly
    * If necessary convert VCF file to a BPC file.  See `BPS_CORE/src/util/processVCF.py` for a basic conversion utility.
* Add new predictions as a new layer in Breakpoint panel; this is implemented as a new step in stage `N_DrawBreakpoint`

For a specific example see novoBreak processing in the TCGA_Virus workflow; specifically, the first two tasks are performed in
the `H_NovoBreak` stage, while the last task is performed in the `N_DrawBreakpoint/4_draw_novoBreak.sh` step.

# Git basics

**This section is under development** 

BreakpointSurveyor relies heavily on `git`, particularly to manage multiple branches 
* `master` (TCGA_Virus workflow)
* `1000SV` 
* `Synthetic` 

If you want to see the various branches and make your own changes, some basic
knowledge of `git` is helpful.  The purpose of this section is to provide some
basics to get started; the free [Pro Git](https://git-scm.com/book/en/v2) reference is highly
recommended for additional reading.

### Getting BreakpointSurveyor and looking around

Topics to cover:
* Cloning repository
  * How to change to see other branches
  * Making your own branch

### Making your own changes

* Making changes and how to keep them 
  * git add, git commit
* How to change, manage branches
* Undoing your changes and starting over

### Sharing your changes 

* how to set up your own remote and why you would want to 
  * useful for development within your group
  * Good way to share data between machines
    * Preliminary processing on server
    * Visualization on laptop
  * Basics of git remote, git push, git pull
* Sharing your changes on github
  * Additions welcome
  * Learning about pull requests as I go along...
