# Filter Discordant

*Extract discordant reads only from prioritized regions of interest, and create BPC file*

There are about 39 million discordant reads in NA19240 dataset.  To keep dataset manageable size,
we keep only a subset of these for further analysis and visualization.

1. Based on top 25 clusters identified in `H_PlotList`, retain only the discordant reads which fall in them, and
   save as a sam file.  This file is still relatively large so is not tracked.
2. Create a BPC file from the SAM file created above, and add attribute indicating mapping direction of read.
