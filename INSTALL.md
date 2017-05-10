# BreakPointSurveyor Installation

## Getting Started

Get a copy of BreakPointSuveyor with,

``` git clone --recursive  https://github.com/ding-lab/BreakPointSurveyor.git ```

This will download the entire BreakPointSurveyor package, including the Core code and the example workflow/data branches.  You can switch between 
the three branches ('master', '1000SV', 'Synthetic') with,

```git checkout XXX```

where `XXX` is one of the three branch names (the 'master' branch contains the TCGA_Virus workflow)

## Distribution

BPS is designed to run on Unix/Linux/OS X command line environment.  

BreakPointSurveyor (BPS) is distributed as two GitHub projects:
* [BreakPointSurveyor-Workflow](https://github.com/ding-lab/BreakPointSurveyor): Three demonstration workflows and associated data 
* [BreakPointSurveyor-Core](https://github.com/ding-lab/BreakPointSurveyor-Core): Data analysis and visualizations scripts

BreakPointSureyor-Core is implemented as a [submodule](https://github.com/blog/2104-working-with-submodules) within BreakPointSurveyor.
Its contents are in the in `bps-core` directory and can be recreated with,

`git submodule update --init --recursive `

After cloning, the `1000SV` and `Synthetic` branches can be accessed with `git checkout <branch>`.
([More about branches](https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell).)

## Software Dependencies

Workflows will have different dependencies - required software and libraries - depending on the tools
they use, but all require libraries used by BPS Core.

### Core

BPS Core applications are written either in R or Python.  Required libraries for each are listed below.

* [Python](https://www.python.org/).  Requires python 2.7 and above.  Developed under 2.7.5.  Not tested in python 3
    * Install `pysam` with, ``` pip install pysam ``` (```--user``` to user directory)
    * Install `pyvcf` similarly
* [R](https://www.r-project.org/).  Developed under R version 3.3.2.
    * Install the following packages at the R console as, ```install.packages("XXX")```
        * ggplot2
          * Requires ggplot2_2.2.0 or newer
        * bitops
        * gridExtra
        * gridBase
        * reshape2
        * stringr
    * Install `DNAcopy` with,
```
source("https://bioconductor.org/biocLite.R")
biocLite("DNAcopy")
```
* [bedtools](http://bedtools.readthedocs.io/en/latest/) Requires v2.20.0 or newer
* [samtools](http://www.htslib.org/download/) Developed with v1.4.1

### Workflow

System dependencies for `master` branch (TCGA_Virus Workflow) listed below.  Additional dependencies for 
other workflows (`1000SV`, `Synthetic` branches) listed in that branch's documentation.

* [bwa](https://sourceforge.net/projects/bio-bwa/files/).  Required for contig realignment (`I_Contig`), novoBreak execution (`H_NovoBreak`),
and creating datasets and references in `Synthetic` and `1000SV` branches.
* [Tigra SV](https://bitbucket.org/xianfan/tigra.git).  Required for contig realignment (stage `I_Contig`)
    * `git clone https://bitbucket.org/xianfan/tigra.git`
    * Modify Makefile as appropriate, `make`, `make install`.
    * Requires [htslib](https://github.com/samtools/htslib) 
* [Pindel](https://github.com/genome/pindel).  Required for Pindel breakpoint detection (stage `F_PindelRP`) 
    * Follow installation instructions on web site.  Requires [htslib](https://github.com/samtools/htslib) 
* [novoBreak](https://sourceforge.net/projects/novobreak/).  Required for novoBreak breakpoint detection (stage `H_NovoBreak`)
    * Source available with, `git clone https://git.code.sf.net/p/novobreak/git novobreak-git` 
* [ImageMagick](https://www.imagemagick.org/script/download.php).  Needed for converting PDF images to PNG in stages `T_PlotStructure` and
`U_PlotExpression`.

## Configuration

All workflow-wide configuration is specified in `bps.config` and possibly `bps.config.local`.  Specifically, 
paths to the above workflow dependencies, are defined there.  Other system wide-variables are defined there as well.

In some cases, it might be inconvient to define all local configurations in the version-controlled `bps.config` file.  You can add 
or override any definitions in the `bps.config` file by placing them in the `bps.config.local` file (which git will ignore).  Both
`bps.config` and `bps.config.local` are read as shell scripts.



