# add CBS segments to depth plots
FLANKN="50K"

DATD_DEP="../H_ReadDepth/DEPTH"
DATD_PL="../G_PlotList/dat"
PLOT_LIST="$DATD_PL/TCGA_SARC.PlotList.${FLANKN}.dat"

BIN="/Users/mwyczalk/Data/BreakpointSurveyor/BreakpointSurveyor/src/plot/DepthDrawer.R"

IND="GGP.CTX"
OUTD="GGP.CBS"
mkdir -p $OUTD

rm -f GGP
ln -s $OUTD GGP

# The flagstat data file contains pre-calculated statistics about BAM partly obtained from
# the BAM's flagstat file.
# For normalizing read depth, we use number of mapped reads and read length 
# normalize read depth by num_reads * bp_per_read / (2 * num_reads_in_genome)
FLAGSTAT="$DATD_DEP/TCGA_SARC.flagstat.dat"

# usage: process_chrom CHROM_ID BAR NAME CHROM RANGE_START RANGE_END
# CHROM_ID is either A or B
function process_chrom {
    CHROM_ID=$1
    BAR=$2
    NAME=$3
    CHROM=$4
    START=$5
    END=$6

    DEP="$DATD_DEP/${BAR}/${NAME}.${CHROM_ID}.${FLANKN}.DEPTH.dat"

    GGP="$IND/${BAR}/${NAME}.${CHROM_ID}.${FLANKN}.depth.ggp"

    OUTDD="$OUTD/$BAR"
    mkdir -p $OUTDD
    OUT="$OUTDD/${NAME}.${CHROM_ID}.${FLANKN}.depth.ggp"


    # barcode	filesize	read_length	reads_total	reads_mapped
    # TCGA-DX-A1KU-01A-32D-A24N-09	163051085994	100	2042574546	1968492930
    NUMREADS=`grep $BAR $FLAGSTAT | cut -f 5`  # using number of mapped reads
    READLEN=`grep $BAR $FLAGSTAT | cut -f 3`
    # TODO: deal gracefully if numreads, readlen unknown.

    ARGS=" -A ${CHROM}:${START}-${END} -m $CHROM_ID -u $NUMREADS -l $READLEN "

# Usage: Rscript DepthDrawer.R [-v] [-P] [-A range] [-F] [-G fn.ggp] [-p plot.type]
#                [-u num.reads] [-l read.length] [-m chrom] [-C] [-L]
#                [-a alpha] [-c color] [-f fill] [-s shape][-z size] data.fn depth.ggp
    Rscript $BIN $ARGS -G $GGP -p CBS -c "#E41A1C" $DEP $OUT
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

