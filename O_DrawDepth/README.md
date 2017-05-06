# DrawDepth

*Create read depth/copy number panel GGP and add breakpoint predictions*

See [N_DrawBreakpoint](../N_DrawBreakpoint/README.md) and the [developer guide](../Development.md) for details about plotting.

* `1_make_depth_ggp.sh` Create GGP with read depth as scatter plot
    * Can plot read depth (RD), copy number, or log(RD/average(RD))
* `2_add_CBS.sh` Add red lines indicating "average" read depth based on [circular binary segmentation](https://bioconductor.org/packages/release/bioc/html/DNAcopy.html)
* `3_prep_ICB_annotation.sh` Create a BPC-like file which contains discordant reads mapping to given chrom from any other chromosome (not just the 
other chromosome in this plot), to aid interpretation of complex, multi-chromosomal events.
* `4_add_Discordant.sh` Add Discordant breakpoint positions (scattered along vertical axis).  Color indicates the chromosome discordant read maps to.


