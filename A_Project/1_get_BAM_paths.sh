# List of paths to aligned BAM files

source ./Project.config

OUT="$OUTD/WGS.samples.dat"

echo -e "barcode\tdisease\tBAM_path\tref_path" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
TCGA-BA-4077-01B-01D-2268-08 HNSC /home/archive/mwyczalk/BreakPointSurveyor.TCGA_Data/248c12a95d464254bc62d627d3db8152.bam /home/archive/mwyczalk/BreakPointSurveyor.TCGA_Data/all_sequences.fa
EOF

echo Written to $OUT
