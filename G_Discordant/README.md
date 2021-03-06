# Discordant
*Process realigned BAM file to extract discordant human-virus reads*

Proceeds in two steps:

## Step 1

Extract from BAMs all virus reads and human->virus paired-end discordant reads.
Two files are created for each BAM:

* `virus_XXX.sam` - has all reads which contain a virus
* `discordant_XXX.sam` - subset of above which has just reads which map to human whose mate maps to virus

This step can be time consuming, so support provided for cluster queuing system (bsub)

**Note** Due to TCGA restrictions we do not distribute the virus and discordant .sam files

## Step 2

Create BPC (breakpoint coordinates) file which lists human-virus discordant reads.
This is written to `dat/BPC/XXX_Discordant.BPC.dat`

