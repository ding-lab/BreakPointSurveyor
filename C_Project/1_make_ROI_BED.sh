# Generate BED file indicating region of interest we'll be focusing on
# see ../README.md for details

source ./Project.config

OUT="$OUTD/1000SV.ROI.bed"

cat <<EOF | tr ' ' '\t' | bedtools sort >> $OUT
# AQ event, +/- 50Kbp
chr10 41804249 41965847 
chr20 31001980 31291883
# AU event, +/- 50Kbp
chr13 62897705 63111713 
chr17 22074735 22230085
EOF

echo Written to $OUT
