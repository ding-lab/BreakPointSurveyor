# List of paths to aligned BAM files

source ./BPS_Stage.config

# SAMPLE_LIST is defined in bps.config so that it is uniform across all stages

OUT=$SAMPLE_LIST

printf "barcode\tdisease\tBAM_path\tref_path\n" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
TCGA-BA-4077-01B-01D-2268-08 HNSC /home/archive/mwyczalk/BreakPointSurveyor.TCGA_Data/248c12a95d464254bc62d627d3db8152.bam /home/archive/mwyczalk/BreakPointSurveyor.TCGA_Data/GRCh37-lite-+-selected-virus-2013.9.a/all_sequences.fa
EOF

echo Written to $OUT
