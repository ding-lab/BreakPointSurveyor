# Evaluate flagstat statistics for RNA-Seq data.  See 3_ for details.

source ./ReadDepth.config

RNA_SAMPLE_LIST="$BPS_DATA/C_Project/dat/RNA-Seq.samples.dat"

OUT="$OUTD/RNA-Seq.flagstat.dat"

# Usage: parse_flagstat barcode bampath 
# Writes flagstat statistics to $OUT. Statistics include,
# file size, read length, total reads, mapped reads
function parse_flagstat {
    BAR=$1
    BAM=$2

    # Deal appropriately with missing BAM file
    if [ ! -e $BAM ];
    then
        echo BAM file missing: $BAM
        continue
    fi
    # read length is based on length of first read in BAM file - assuming they are all the same!
    SEQ=`samtools view $BAM | head -n1 | cut -f 10`
    READLEN=`expr length $SEQ`

    # FLAGSTAT=${BAM}.flagstat    # This if flagstat is based on BAM filename
    FLAGSTAT="$OUTD/flagstat/${BAR}.flagstat"  # this if flagstat created in step 2_

    # Deal appropriately with missing flagstat file
    if [ ! -e $FLAGSTAT ];
    then
        echo Flagstat file missing: $FLAGSTAT
        continue
    fi
    TOT=`grep "in total" $FLAGSTAT | awk '{print $1}'`
    MAPPED=`grep "mapped (" $FLAGSTAT | awk '{print $1}'`

    BAMF=`readlink -f $BAM`   # BAMF is canonical filename, with all links dereferenced.
    FILESIZE=`stat -c%s $BAMF`
    echo -e "${BAR}\t${FILESIZE}\t${READLEN}\t${TOT}\t${MAPPED}" >> $OUT
}


echo -e "barcode\tfilesize\tread_length\treads_total\treads_mapped" > $OUT

while read l; do

# Skip comments and header
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# extract sample names
BAR=`echo "$l" | cut -f 1`
BAM=`echo "$l" | cut -f 3`

parse_flagstat $BAR $BAM

done < $RNA_SAMPLE_LIST

echo Written to $OUT
