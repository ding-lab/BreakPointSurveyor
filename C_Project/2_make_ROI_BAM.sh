# List of paths to aligned BAM files

# for 1000SV, reference obtained from alignment file

source ./Project.config

OUT="$OUTD/NA19240.ROI.bam"

DAT="/diskmnt/Datasets/1000G_SV/ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/hgsv_sv_discovery/data/YRI/NA19240/high_cov_alignment/NA19240.alt_bwamem_GRCh38DH.20150715.YRI.high_coverage.cram"
BED="$OUTD/1000SV.ROI.bed"

samtools view -L $BED -b -o $OUT $DAT

echo Written to $OUT
