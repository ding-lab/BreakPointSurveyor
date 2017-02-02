# Create RPKM read data for all RNA-Seq BAM files
#
# RPKM is calculated for a domain as,
#   RPKM = number mapped reads * 1e9 / (domain size * mapped reads)
#
# Number of mapped reads and domain size are reported by coverageBed (columns 5 and 7, resp)
# and number of mapped reads is taken from the flagstat file.

# Support provided for cluster queuing system (bsub)
# Turn queuing on/off with USE_BSUB=1/0
USE_BSUB=1

source ./Expression.config
OUTDD="$OUTD/RPKM"
mkdir -p $OUTDD

DATA_LIST="$BPS_DATA/A_Project/dat/TCGA_Virus.samples.RNA-Seq.dat"
BEDD="$OUTD/BED"
FLAGDAT="$BPS_DATA/H_ReadDepth/dat/TCGA_Virus.RNA-Seq.flagstat.dat"

if [ $USE_BSUB == 1 ]; then
    # using bsub
    mkdir -p bsub
    BSUBOUT="bsub/run-all.4_get_RPKM.sh"
    rm -f $BSUBOUT
fi

function process {
    BAR=$1
    DIS=$2
    BAM=$3

    BED="$BEDD/$DIS.roi.bed"
    OUT="$OUTDD/$BAR.rpkm"

    MAPCOUNT=`grep $BAR $FLAGDAT | cut -f 5`

    # coverageBed output:
    # chr9    140335737   140335901   ENTPD8  0   0   164 0.0000000

    # TODO: follow technique in ../D_Discordant/1_get_Discordant_reads.sh to first construct a command, then
    # execute it either here or in bsub
    if [ $USE_BSUB == 0 ]; then
        echo Running $BAR
        samtools view -b -L $BED $BAM | bedtools bamtobed -split -i stdin | coverageBed -a stdin -b $BED | \
            awk -v mc=$MAPCOUNT 'BEGIN{FS="\t";OFS="\t"}{print $1,$2,$3,$4,$5*1e9/($7*mc)}' > $OUT
        echo Written to $OUT
    else
        SCRIPT="bsub/run_$BAR.sh"
        echo Writing to $SCRIPT
        CMD="samtools view -b -L $BED $BAM | bedtools bamtobed -split -i stdin | coverageBed -a stdin -b $BED | \
            awk -v mc=$MAPCOUNT 'BEGIN{FS=\"\t\";OFS=\"\t\"}{print \$1,\$2,\$3,\$4,\$5*1e9/(\$7*mc)}' > $OUT"
        echo $CMD > $SCRIPT
        echo "bsub -oo bsub/out-4.$BAR.bsub sh $SCRIPT" >> $BSUBOUT
    fi
    exit
}

while read l
do
#barcode    disease BAM_path
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# extract sample names
BAR=`echo "$l" | cut -f 1`
DIS=`echo "$l" | cut -f 2`     
BAM=`echo "$l" | cut -f 3`

process $BAR $DIS $BAM

done < $DATA_LIST

if [ $USE_BSUB == 1 ]; then
    # using bsub
    echo Please run $BSUBOUT
fi
