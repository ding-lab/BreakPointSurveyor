# PindelRP

*Run PindelRP to detect interchromosomal breakpoints*

[Pindel](https://github.com/genome/pindel) can detect breakpoints of large deletions, medium sized insertions,
inversions, tandem duplications and other structural variants at single-based
resolution from next-gen sequence data. It uses a pattern growth approach to
identify the breakpoints of these variants from paired-end short reads. 

* Pindel is configured to evaluate only discordant reads which map to virus.  
* Pindel RP (Read Pair) output is converted to [BPR format](../bps-core/doc/FileFormat.md).

