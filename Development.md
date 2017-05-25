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

BreakpointSurveyor relies heavily on `git`, particularly to manage multiple branches, with each branch
demonstrating a different workflow.  Branches distributed with BreakpointSurveyor are,
* `master` (TCGA_Virus workflow)
* `1000SV` 
* `Synthetic` 

To examine, execute, and modify the various branches some basic knowledge of
`git` is helpful.  Here we provide some basics to get started; the free [Pro
Git](https://git-scm.com/book/en/v2) reference is highly recommended for
additional reading.

### Getting BreakpointSurveyor and looking around

After BPS is cloned from GitHub with,

``` git clone --recursive  https://github.com/ding-lab/BreakPointSurveyor.git ```

you can see which branch you are on and switch branches with,

```
git branch
git checkout *branch_name*
```

Branches are useful if you want to make modifications to BPS while keeping the original branches
intact.  Make your own branch and switch to it with,

```
git branch *new_branch_name*
git checkout *new_branch_name*
```

### Making your own changes

As you make changes to BPS and want to keep a history of your edits and the new data, you will want to
periodically add your changes to the branch's revision history using `git commit`.  To do so, first
examine the changes you've made with,

```git status```

Select the changes you want to commit with,

``` git add *filename* ```

(and use `git rm *filename*` to delete tracked files).  Finally,

```git commit```

will store the changes.  (You'll be asked for a brief description of the changes.)  Note that you'll need
generally need to commit your changes before changing branches (or else use `git stash`).

Any changes you make to BPS can be easily undone.  For example, if you are working on your own branch, 
you can discard all changes and revert to an unmodified branch with, e.g., `git checkout master`.

### Sharing your changes 

Sharing your code internally (i.e., not to GitHub) is useful for several reasons:

* To share changes with other members of your team
* To execute different stages on different computers.  For instance, preliminary processing can be
performed on a high performance cluster, and visualization on a laptop.  Processed data is shared
by committing it to the repository.

Create a new repository with,

``` git init --bare /my/path/src/BreakpointSurveyor.git ```

In your working BPS branch (with the edits you wish to share), add the new external reposity with,

``` git remote add origin ssh://user_name@hostname/my/path/src/BreakpointSurveyor.git/ ```

You can then share commits from your local repository to the external one with,

``` 
git push origin *branch_name* 
git pull origin *branch_name* 
```

Finally, we welcome additions and improvements to BPS at the [GitHub](https://github.com/ding-lab/BreakPointSurveyor) repository.
Please contact us for more details.
