
source ./Project.config

OUT="$OUTD/WGS.samples.dat"

echo -e "barcode\tdisease\tBAM_path\tref_path" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
synthetic.9-22 NA $OUTD/synthetic.BWA.bam $BPS_DATA/A_Reference/dat/reference.chr9_chr22.fa
EOF

echo Written to $OUT
