# Discordant
*Process realigned BAM file to extract discordant human-virus reads*

Extract all paired-end discordant reads (i.e., reads of a pair map to different chrom) which have MAPQ>=25.
Write `dat/discordant_XXX.sam`
