# Generate flagstat files summarizing BAM read counts.
# see 3_makeReadCoverage.sh for details about flagstat files
# This step is optional: some workflows generate flagstat files automatically.
# Information is necessary only for normalizing read depth to get copy number

source ./ReadDepth.config

PLOT_LIST="$BPS_DATA/G_PlotList/dat/1000SV.PlotList.50K.dat"
DATA_LIST="$BPS_DATA/A_Project/dat/1000SV.samples.dat"

function make_flagstat {
    BAR=$1
    BAM=$2

    OUT="$OUTD/${BAR}.flagstat"

    samtools flagstat $BAM > $OUT
    echo Written to $OUT
}

while read l; do
# barcode	bam_path	build_id	data_path

# Skip comments and header
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# extract sample names
BAR=`echo "$l" | cut -f 1`
BAM=`echo "$l" | cut -f 2`

echo Processing flagstat $BAR $BAM

make_flagstat $BAR $BAM

done < $DATA_LIST

