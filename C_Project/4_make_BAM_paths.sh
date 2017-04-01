# List of paths to aligned BAM files

# for 1000SV, reference obtained from alignment file

source ./BPS_Stage.config

OUT="$OUTD/BPSsamples.dat"

U_OUTD="$BPS_DATA/C_Project/dat.untracked"

echo -e "barcode\tdisease\tBAM_path\tref_path" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
NA19240.AQ NA $U_OUTD/NA19240.AQ.bam $BPS_DATA/A_Reference/dat.untracked/GRCh38_full_analysis_set_plus_decoy_hla.fa
NA19240.AU NA $U_OUTD/NA19240.AU.bam $BPS_DATA/A_Reference/dat.untracked/GRCh38_full_analysis_set_plus_decoy_hla.fa
EOF

echo Written to $OUT
