# create chrom.depth GGP for every row in PlotList.dat
DATD="../A_Data/origdata"

FLANKN="50K"
PLOT_LIST="$DATD/BP/PlotList.BPS.${FLANKN}.dat"

BIN="/Users/mwyczalk/Data/TCGA_SARC/ICGC/BreakpointSurveyor/F_ReadDepth/src/DepthCruncher.R"

# FLAGSTAT="$DATD/read_count_map.dat"
    # The flagstat data file contains pre-calculated statistics about BAM partly obtained from
    # the BAM's flagstat file.
    # For normalizing read depth, we use number of mapped reads and read length 
    # normalize read depth by num_reads * bp_per_read / num_reads_in_genome
    # currently we don't have this information calculated for test data

    #barcode	analysis	reads_total	reads_mapped	read_length
    #TCGA-AK-3455-01A-01D-2233-10	WGS	990044820	943303610	101
    # NUMREADS=`grep $BAR $FLAGSTAT | cut -f 4`  # using number of mapped reads
    # READLEN=`grep $BAR $FLAGSTAT | cut -f 5`

    # -u $NUMREADS \
    # -l $READLEN \

OUTD="GGP"
mkdir -p $OUTD


# usage: process_chrom CHROM_ID BAR NAME CHROM RANGE_START RANGE_END
# CHROM_ID is either A or B
function process_chrom {
    CHROM_ID=$1
    BAR=$2
    NAME=$3
    CHROM=$4
    START=$5
    END=$6

    DEP="$DATD/DEPTH/${NAME}.${CHROM_ID}.DEPTH.dat"
    #DIS="$DATD/discordant/${BAR}.discordant.dat"
    #PIN="$DATD/RP/${BAR}_RP"   
    #HHRP="$DATD/HHRP/${NAME}_RP" 
    #RSBP="$DATD/rSBP/$BAR.rSBP.dat"
    #if [ -e $RSBP ]; then
    #    RSBPF="-r $RSBP"
    #fi

    OUT="$OUTD/${NAME}.${CHROM_ID}.DEPTH.ggp"
    #OUT="$OUTD/${NAME}.${CHROM_ID}.${FLANKN}.depth.ggp"

    ARGS=" \
    -C \
    -a $START \
    -b $END \
    -c $CHROM \
    -n $NAME "

    # Usage: Rscript DepthCruncher.R [-v] [-C] [-P] [-s discordant.dat] [-p pindel_RP.dat] [-R HHRP] [-r rSBP.dat] [-V] [-L] [-u num.reads] [-l read.length]
    #                                 -a chrom.range.start -b chrom.range.end -c chrom -n integration.event.name depth.dat depth.ggp
    #Rscript src/DepthCruncher.R $ARGS -s $DIS -p $PIN $RSBPF -R $HHRP $DEP $OUT
    Rscript $BIN $ARGS $DEP $OUT
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

