# List of paths to aligned BAM files

source ./Project.config

OUT="$OUTD/bam_path.dat"

echo -e "barcode\tdisease\tBAM_path\tref_path" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
TCGA-BA-4077-01B-01D-2268-08 HNSC /gscmnt/gc9006/info/model_data/0919da4644ed424498cedffaadfa0f86/build6a566c3c3cc640249de2cebdc9e9a1c3/alignments/248c12a95d464254bc62d627d3db8152.bam /gscmnt/gc9008/info/model_data/881e20d5404b453ea61632130577130c/build922230c747f14d288b8e73ca81d18a04/all_sequences.fa
EOF

echo Written to $OUT
