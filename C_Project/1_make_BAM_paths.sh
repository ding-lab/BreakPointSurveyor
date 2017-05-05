# List of paths to aligned BAM files

# for 1000SV, reference obtained from alignment file

# Note, SAMPLE_LIST is defined in ../bps.config

source ./BPS_Stage.config

# Here we write BPS.samples.dat which refers to the original 1000SV data
SAMPLE_LIST="$BPS_DATA/C_Project/dat/BPS.samples.dat"

U_OUTD="$BPS_DATA/C_Project/dat.untracked"

cat <<EOF | sort | tr ' ' '\t' > $SAMPLE_LIST
barcode disease BAM_path ref_path
NA19240 NA $BAM_ORIG $BPS_DATA/A_Reference/dat.untracked/GRCh38_full_analysis_set_plus_decoy_hla.fa
EOF

echo Written to $SAMPLE_LIST
