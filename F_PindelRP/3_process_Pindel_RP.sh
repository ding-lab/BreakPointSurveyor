# Process Pindel RP data into BPR file

# Writes dat/BAR.PindelRP.BPR.dat for each sample

source ./BPS_Stage.config

BIN="$BPS_CORE/src/analysis/Pindel_RP.Reader.R"

OUTDD="$OUTD/BPR"
mkdir -p $OUTDD

function process {
    BAR=$1

    RP="dat/${BAR}_RP"
    ARGS="-S -V" 
    OUT="$OUTDD/${BAR}.PindelRP.BPR.dat"

    # keep only first 12 columns of Pindel_RP file
    cut -f 1-12 $RP | Rscript $BIN $ARGS stdin $OUT

}

while read l; do
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

    BAR=`echo $l | awk '{print $1}'`
    BAM=`echo $l | awk '{print $3}'`
    REF=`echo $l | awk '{print $4}'`

    process $BAR 

    echo Written to $OUT

done < $SAMPLE_LIST

