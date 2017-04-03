
source ./BPS_Stage.config

OUT=$SAMPLE_LIST

cat <<EOF | sort | tr ' ' '\t' > $OUT
barcode disease BAM_path ref_path
synthetic.9-22 NA $OUTD/synthetic.BWA.bam $BPS_DATA/A_Reference/dat.untracked/reference.chr9_chr22.fa
EOF

echo Written to $OUT
