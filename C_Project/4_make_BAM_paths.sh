# List of paths to aligned BAM files

# for 1000SV, reference obtained from alignment file

# Note, SAMPLE_LIST is defined in ../bps.config

source ./BPS_Stage.config

U_OUTD="$BPS_DATA/C_Project/dat.untracked"

cat <<EOF | sort | tr ' ' '\t' > $SAMPLE_LIST
barcode disease BAM_path ref_path
NA19240.AQ NA $U_OUTD/NA19240.AQ.bam $BPS_DATA/A_Reference/dat.untracked/GRCh38_full_analysis_set_plus_decoy_hla.fa
NA19240.AU NA $U_OUTD/NA19240.AU.bam $BPS_DATA/A_Reference/dat.untracked/GRCh38_full_analysis_set_plus_decoy_hla.fa
EOF

echo Written to $SAMPLE_LIST
