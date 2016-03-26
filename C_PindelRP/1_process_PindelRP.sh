# Process Pindel RP data into BPR file

# Writes dat/BAR.PindelRP.BPR.dat for each sample

source ./PindelRP.config

DATA_LIST="$BPS_DATA/A_Project/dat/1000SV.samples.dat"
BIN="$BPS_CORE/src/analysis/Pindel_RP.Reader.R"
echo Data list: $DATA_LIST
echo \$BIN: $BIN

while read l; do
# barcode	bam_path	CTX_path	Pindel_path
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

BAR=`echo $l | awk '{print $1}'`
PIN_FN=`echo $l | awk '{print $4}'`   # read column 3


ARGS="-S" 
OUT="$OUTD/${BAR}.PindelRP.BPR.dat"

# keep only first 12 columns of Pindel_RP file
cut -f 1-12 $PIN_FN | Rscript $BIN $ARGS stdin $OUT

echo Written to $OUT

done < $DATA_LIST

