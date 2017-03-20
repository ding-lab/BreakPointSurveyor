# List of paths to aligned BAM files

# for 1000SV, reference obtained from alignment file

source ./Project.config

OUT="$OUTD/WGS.samples.dat"

echo -e "barcode\tdisease\tBAM_path\tref_path" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
NA19240 NA $OUTD/NA19240.AQ.bam GRCh38_full_analysis_set_plus_decoy_hla.fa
NA19240 NA $OUTD/NA19240.AU.bam GRCh38_full_analysis_set_plus_decoy_hla.fa
EOF

echo Written to $OUT
