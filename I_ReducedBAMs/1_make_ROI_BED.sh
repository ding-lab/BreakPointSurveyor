# Generate BED file indicating region of interest we'll be focusing on
# see ../README.md for details

source ./BPS_Stage.config

OUT="$OUTD/1000SV.ROI.bed"

cat <<EOF | tr ' ' '\t' | bedtools sort > $OUT
# AQ event, +/- 50Kbp
chr10 41804249 41965847 AQa
chr20 31001980 31291883 AQb
# AU event, +/- 50Kbp
chr13 62897705 63111713 AUa
chr17 22074735 22230085 AUb
EOF

echo Written to $OUT
