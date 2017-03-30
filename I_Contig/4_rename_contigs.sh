# tigra-sv sometimes creates pathologically long contig names (QNAME field of SAM)
# which makes samtools (and pysam) choke.  To get around this, convert QNAMEs in all
# SAM files to a hex string using an MD5 hash; matching QUNAMEs will remain matching,
# which is important for the processing here.

source ./BPS_Stage.config
BIN="/usr/bin/python2.7 $BPS_CORE/src/contig/qname_convert.py"

DATD="$OUTD/BWA" # BWA-mem output SAM files:

OUTDD="$OUTD/SAM"
mkdir -p $OUTDD

function process {
    BAR=$1
    DAT="$DATD/${BAR}.sam"
    OUT="$OUTDD/${BAR}.QMD5.sam"

    cat $DAT | $BIN > $OUT 
    echo Written to $OUT
}

while read l; do  # iterate over all rows of samples.dat

    # Skip comments and header
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    BAR=`echo $l | awk '{print $1}'`

    process $BAR

done < $SAMPLE_LIST

