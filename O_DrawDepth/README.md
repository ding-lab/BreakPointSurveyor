# O_DrawDepth

*Create read depth/copy number panel GGP and add breakpoint predictions*

* **`1_make_depth_ggp.sh`** Create GGP with read depth as scatter plot
    * Can plot read depth (RD), copy number, or log(RD/average(RD))
* **`2_add_CBS.sh`** Add red lines indicating "average" read depth based on 
  [circular binary segmentation](https://bioconductor.org/packages/release/bioc/html/DNAcopy.html)
* **`3_add_PindelRP.sh`** Add Pindel breakpoint positions
* **`4_add_Discordant.sh`** Add Discordant breakpoint positions (scattered along vertical axis)
* **`5_add_Contig.sh`** Add Contig breakpoint positions
