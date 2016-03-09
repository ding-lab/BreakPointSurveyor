# create two GGP for every row in PlotList
FLANKN="50K"
DATD="../A_Data/origdata"

PLOT_LIST="../B_PlotList/dat/Combined.PlotList.${FLANKN}.dat"

BIN="/Users/mwyczalk/Data/BreakpointSurveyor/BreakpointSurveyor/src/plot/DepthCruncher.R"

# not currently implemented.  Should be calculated along with read depth.
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

OUTD="GGP.DEP"
mkdir -p $OUTD

# the aim is to make ./GGP a link to the most current GGP files
ln -s $OUTD GGP


# usage: process_chrom CHROM_ID BAR NAME CHROM RANGE_START RANGE_END
# CHROM_ID is either A or B
function process_chrom {
    CHROM_ID=$1
    BAR=$2
    NAME=$3
    CHROM=$4
    START=$5
    END=$6

    DEP="../C_ReadDepth/DEPTH/${BAR}/${NAME}.${CHROM_ID}.${FLANKN}.DEPTH.dat"

    OUTDD="$OUTD/$BAR"
    mkdir -p $OUTDD

    OUT="$OUTDD/${NAME}.${CHROM_ID}.${FLANKN}.depth.ggp"

    ARGS=" -A ${CHROM}:${START}-${END}"

# Usage: Rscript DepthCruncher.R [-v] [-P] [-A range] [-F] [-g fn.ggp] [-p plot.type]
#                [-u num.reads] [-l read.length] [-m chrom] [-C] [-L]
#                [-a alpha] [-c color] [-f fill] [-s shape][-z size] data.fn depth.ggp

    Rscript $BIN $ARGS -p depth $DEP $OUT
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
exit

done < $PLOT_LIST

