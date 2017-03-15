# Make BAM

Here we generate a small BAM based on human reference with a breakpoint 
at a specified position between chr9:130,850,000 and chr22:23,260,000

## Procedure:
* Download two human genome segments, each 10Kb in size, and combine them into one fasta
* Generate synthetic reads using wgsim
* Align synthetic reads using bwa to generate synthetic BAM file

*NOTE* breakpoint seems to occur on 
* chr9:128,087,721
* chr22:22,917,830
