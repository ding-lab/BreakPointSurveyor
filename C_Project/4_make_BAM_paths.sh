
source ./BPS_Stage.config

OUT="$OUTD/samples.dat"

echo -e "barcode\tdisease\tBAM_path\tref_path" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
synthetic.9-22 NA $OUTD/A_Reference/dat.untracked/synthetic.BWA.bam $BPS_DATA/reference.chr9_chr22.fa
EOF

echo Written to $OUT
