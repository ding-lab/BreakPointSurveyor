# Project

The goal of this stage is to create dat/BPSsamples.dat, which defines sequence datasets we will analyze
in BreakpointSurveyor.  We also create a reduced-size BAM file which contains reads only from regions
of interest to make downstream analysis faster.

Constructing a "minimal" BAM to demonstrate events.

# AQ event, +/- 50Kbp
chr10 41804249 41965847 AQa
chr20 31001980 31291883 AQb
# AU event, +/- 50Kbp
chr13 62897705 63111713 AUa
chr17 22074735 22230085 AUb

ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/hgsv_sv_discovery/data/YRI/NA19240/high_cov_alignment/NA19240.alt_bwamem_GRCh38DH.20150715.YRI.high_coverage.cram

Steps 1-3 are optional.  They are used to create a smaller BAM file to make downstream analysis faster.
If you wish to analyze an entire sequence file, simply edit and run 4_make_BAM_paths.sh with the location of the BAM file(s); this generates dat/BPSsamples.dat.

*Performance*
Step 2 takes about 5 minutes (check)
Step 3 takes about 2 minutes (confirmed)
