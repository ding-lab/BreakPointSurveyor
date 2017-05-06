# prepare interchromosomal breakpoint data

# Create a custom datafile for each depth panel.  From filtered discordant BPC data, create BPC-like dataset
# which is filtered to retain only reads containing chrom of interest, rearranged as necessary so
# chrom of interest is first (chromA).  Second chrom is also written as attribute

source ./BPS_Stage.config


DATD="$BPS_DATA/I_FilterDiscordant/dat"

OUTDD="$OUTD/ICB"
mkdir -p $OUTDD

# CHROM_ID is either A or B
function process_chrom {
    CHROM_ID=$1
    BAR=$2
    NAME=$3
    CHROM=$4
    START=$5
    END=$6
    N_CHROM=$7   # N_ is the "opposite" chrom or virus
    N_START=$8
    N_END=$9

    BPC="$DATD/BPC/${BAR}.Discordant.BPC.dat"
    # chr10 41817042    chr4    49711560    Reverse
    OUT="$OUTDD/${NAME}.${CHROM_ID}.ICB.dat"

    awk -v c=$CHROM 'BEGIN{FS="\t";OFS="\t"}{if ($1 == c) print $1,$2,$3,$4,$3; else if ($3 == c) print $3,$4,$1,$2,$1}' $BPC > $OUT
    echo Written to $OUT
}

while read l; do  
# barcode name    chrom.A event.A.start   event.A.end range.A.start   range.A.end chrom.B event.B.start   event.B.end range.B.start   range.B.end
# TCGA-IS-A3KA-01A-11D-A21Q-09    TCGA-IS-A3KA-01A-11D-A21Q-09.chr_1_2.aa 1   5156542 207193935   5106542 207243935   2   122476446   228566993   122426446   228616993

# Skip comments and header
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# extract sample names
BAR=`echo "$l" | cut -f 1`
NAME=`echo "$l" | cut -f 2`     

A_CHROM=`echo "$l" | cut -f 3`
A_START=`echo "$l" | cut -f 6`
A_END=`echo "$l" | cut -f 7`

B_CHROM=`echo "$l" | cut -f 8`
B_START=`echo "$l" | cut -f 11`
B_END=`echo "$l" | cut -f 12`

process_chrom A $BAR $NAME $A_CHROM $A_START $A_END $B_CHROM $B_START $B_END
process_chrom B $BAR $NAME $B_CHROM $B_START $B_END $A_CHROM $A_START $A_END

done < $PLOT_LIST

