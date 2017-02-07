# Add Pindel_RP annotation to depth plots

source ./DrawDepth.config

FLANKN="50K"

DATD="$BPS_DATA/F_PindelRP/dat"
PLOT_LIST="$BPS_DATA/J_PlotList/dat/TCGA_Virus.PlotList.50K.dat"

#PLOT_LIST="./test.PlotList.dat"
# echo Using $PLOT_LIST for testing only

BIN="$BPS_CORE/src/plot/DepthDrawer.R"

IND="$OUTD/GGP.CBS"
OUTDD="$OUTD/GGP.PindelRP"
mkdir -p $OUTDD

rm -f $OUTD/GGP  # GGP is a link
ln -s ../$OUTDD $OUTD/GGP

# usage: process_chrom CHROM_ID BAR NAME CHROM RANGE_START RANGE_END
# CHROM_ID is either A or B
function process_chrom {
    CHROM_ID=$1
    BAR=$2
    NAME=$3
    CHROM=$4
    START=$5
    END=$6

    BPR="$DATD/BPR/${BAR}.PindelRP.BPR.dat"

    GGP="$IND/${BAR}/${NAME}.${CHROM_ID}.${FLANKN}.depth.ggp"

    OUTDDD="$OUTDD/$BAR"
    mkdir -p $OUTDDD
    OUT="$OUTDDD/${NAME}.${CHROM_ID}.${FLANKN}.depth.ggp"

    # Make Pindel annotation light gray and partly transparent
    COLOR="-a 0.1 -f gray10"
    ARGS=" -M ${CHROM}:${START}-${END} -m $CHROM_ID $COLOR"
    if [ $FLIPAB == 1 ]; then     # defined in ../bps.config
        ARGS="$ARGS -l"
    fi

    Rscript $BIN $ARGS -G $GGP -p region $BPR $OUT
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

process_chrom A $BAR $NAME $A_CHROM $A_START $A_END
process_chrom B $BAR $NAME $B_CHROM $B_START $B_END

done < $PLOT_LIST

