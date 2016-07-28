# List of paths to aligned BAM files

source ./Project.config

OUT="$OUTD/bam_path.dat"

echo -e "barcode\tdisease\tBAM_path\tref_path" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
TCGA-BA-4077-01B-01D-2268-08 HNSC /gscmnt/gc9006/info/model_data/0919da4644ed424498cedffaadfa0f86/build6a566c3c3cc640249de2cebdc9e9a1c3/alignments/248c12a95d464254bc62d627d3db8152.bam /gscmnt/gc9008/info/model_data/881e20d5404b453ea61632130577130c/build922230c747f14d288b8e73ca81d18a04/all_sequences.fa
TCGA-BT-A20V-01A-11D-A14W-08 BLCA /gscmnt/gc9006/info/model_data/538953db7b524d1d99af24d78684a94f/buildd900cf9094914665bc54e99a838a860a/alignments/84d6901ea7314c22b44dae052b283c01.bam /gscmnt/gc9008/info/model_data/881e20d5404b453ea61632130577130c/build922230c747f14d288b8e73ca81d18a04/all_sequences.fa
TCGA-CR-7385-01A-11D-2268-08 HNSC /gscmnt/gc9006/info/model_data/45af648642e74ed59c0966418381a8c3/buildfb0aabb73d4049b78de1f0fd87895c33/alignments/9429d27280a64beaabb5dab201c4684f.bam /gscmnt/gc9008/info/model_data/881e20d5404b453ea61632130577130c/build922230c747f14d288b8e73ca81d18a04/all_sequences.fa
TCGA-CV-5971-01A-11D-1681-02 HNSC /gscmnt/gc9006/info/model_data/ce7cab2aede242c8b9560c31ca6063fd/build66949258432e4365aa782a293c65abb0/alignments/cdf56d26c9f24e2d8e3d71c715a8e372.bam /gscmnt/gc9008/info/model_data/881e20d5404b453ea61632130577130c/build922230c747f14d288b8e73ca81d18a04/all_sequences.fa
TCGA-FD-A3B4-01A-12D-A204-02 BLCA /gscmnt/gc9006/info/model_data/4684e8a4375e4dd4a79283af654ec1a6/build163f6c6f99754e9ea28afff5f67b32bd/alignments/451faffc5da54c47a67a5c1e3b5e20f3.bam /gscmnt/gc9008/info/model_data/881e20d5404b453ea61632130577130c/build922230c747f14d288b8e73ca81d18a04/all_sequences.fa
EOF

echo Written to $OUT
