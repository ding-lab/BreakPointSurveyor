# Discordant
*Process realigned BAM file to extract discordant reads*

Note we're analyzing the original data file, rather than the reduced one generated in `I_ReducedBAMs`

Proceeds in two steps:

## Step 1

Extract all paired-end discordant reads (i.e., reads of a pair map to different chrom) which have MAPQ>=25
Write `dat/discordant_XXX.sam` 

## Step 2

Create BPC (breakpoint coordinates) file which lists all discordant reads.
This is written to `dat/BPC/XXX_Discordant.BPC.dat`

