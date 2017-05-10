source ./BPS_Stage.config

# Create BAM file which only includes reads from region of interest, to streamline
# downstream processing.
#
# It would be simpler to use `samtools view -L BED` to extract segments of the BAM/CRAM
# file, but performance is really slow.  Instead, we'll extract regions one by one, and
# then merge the BAM files individually.


U_OUTD="dat.untracked"
mkdir -p $U_OUTD


# Extracts BAM file from NA19240 for given region 
function process {
    CHR=$1
    START=$2
    END=$3
    NAME=$4
    BAM=$5

    REG="$CHR:$START-$END"
    OUT="$U_OUTD/BA-4077.$NAME.bam"

    # samtools view -L is very slow.
    # instead do this once for multiple regions

    echo Processing $REG
    samtools view -b -o $OUT $BAM $REG

    echo Written to $OUT
}

function process_BED {
    BED=$1
    BAM=$2
    while read l
    do
        # Skip comments 
        [[ $l = \#* ]] && continue

        process $l $BAM
    done < $BED
}

# Generate BED file indicating region of interest we'll be focusing on
# This corresponds to the range of the one integration event in PlotList

BED="$OUTD/BA-4077.ROI.bed"

cat <<EOF | tr ' ' '\t' | bedtools sort > $BED
14 68633616 68791484 chr14
gi|310698439|ref|NC_001526.2| 1 7905 HPV16
EOF

# get the BAM corresponding to BA-4077 from PlotList

BAM=`grep "BA-4077" $SAMPLE_LIST | cut -f 3`

# Obtain BAM file for all regions of interest in BAM
process_BED $BED $BAM
