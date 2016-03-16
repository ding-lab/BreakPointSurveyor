# obtain read count and length for every BAM file in BAM list by reading associated flagstat file
# for filename fn.bam, assume that fn.bam.flagstat exists
# "barcode" is assumed to be unique identifier of BAM file

# Reads A_DataPaths/dat/DDLS_WGS_tumor.dat and flagstat files based on BAM path
# Writes file DEPTH/TCGA_SARC.flagstat.dat

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

BAMLIST="../A_Project/dat/TCGA_SARC.samples.dat"

OUTD="DEPTH"
mkdir -p $OUTD
OUT="$OUTD/TCGA_SARC.flagstat.dat"

# Usage: parse_flagstat barcode bampath 
# Writes flagstat statistics to $OUT. Statistics include,
# file size, read length, total reads, mapped reads
function parse_flagstat {
    BAR=$1
    BAM=$2

    # read length is based on length of first read in BAM file - assuming they are all the same!
    SEQ=`samtools view $BAM | head -n1 | cut -f 10`
    READLEN=`expr length $SEQ`

    FLAGSTAT=${BAM}.flagstat

    # Deal appropriately with missing flagstat file
    if [ ! -e $FLAGSTAT ];
    then
        echo Flagstat file missing: $FLAGSTAT
        continue
    fi
    TOT=`grep "in total" $FLAGSTAT | awk '{print $1}'`
    MAPPED=`grep "mapped (" $FLAGSTAT | awk '{print $1}'`

    FILESIZE=`stat -c%s $BAM`
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

done < $BAMLIST

echo Written to $OUT
