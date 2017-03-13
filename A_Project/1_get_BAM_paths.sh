# List of paths to aligned BAM files

# for 1000SV, reference obtained from alignment file

source ./Project.config

OUT="$OUTD/WGS.samples.dat"

echo -e "barcode\tdisease\tBAM_path\tref_path" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
NA19240 NA /diskmnt/Datasets/1000G_SV/ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/hgsv_sv_discovery/data/YRI/NA19240/high_cov_alignment/NA19240.alt_bwamem_GRCh38DH.20150715.YRI.high_coverage.cram GRCh38_full_analysis_set_plus_decoy_hla.fa
EOF

echo Written to $OUT
