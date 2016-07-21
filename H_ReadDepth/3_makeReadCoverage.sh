# obtain read count and length for every BAM file in BAM list by reading associated flagstat file
# "barcode" is assumed to be unique identifier of BAM file

# Reads flagstat files based on BAM path

# example flagstat file (note, there is some variation in this)
    #415354654 + 0 in total (QC-passed reads + QC-failed reads)
    #7043441 + 0 duplicates
    #376159187 + 0 mapped (90.56%:-nan%)
    #415354654 + 0 paired in sequencing
    #207677327 + 0 read1
    #207677327 + 0 read2
    #367182755 + 0 properly paired (88.40%:-nan%)
    #370872254 + 0 with itself and mate mapped
    #5286933 + 0 singletons (1.27%:-nan%)
    #2136932 + 0 with mate mapped to a different chr
    #1091817 + 0 with mate mapped to a different chr (mapQ>=5)

source ./ReadDepth.config

PLOT_LIST="$BPS_DATA/G_PlotList/dat/TCGA_Virus.PlotList.50K.dat"
DATA_LIST="$BPS_DATA/A_Project/dat/TCGA_Virus.samples.dat"

OUT="$OUTD/TCGA_Virus.flagstat.dat"

# Usage: parse_flagstat barcode bampath 
# Writes flagstat statistics to $OUT. Statistics include,
# file size, read length, total reads, mapped reads
function parse_flagstat {
    BAR=$1
    BAM=$2

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
# barcode	bam_path	build_id	data_path

# Skip comments and header
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# extract sample names
BAR=`echo "$l" | cut -f 1`
BAM=`echo "$l" | cut -f 2`

parse_flagstat $BAR $BAM

done < $DATA_LIST

echo Written to $OUT
