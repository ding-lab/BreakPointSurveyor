# Create GGP object with read depth histogram

source ./DrawHistogram.config
FLANKN="50K"

DATD_DEP="$BPS_DATA/H_ReadDepth/dat"
DATD_PL="$BPS_DATA/G_PlotList/dat"
PLOT_LIST="$BPS_DATA/G_PlotList/dat/TCGA_Virus.PlotList.${FLANKN}.dat"

BIN="$BPS_CORE/src/plot/HistogramDrawer.R"

# Histogram options are defined in the file below.  Only hist.max is currently supported.
# This is a mechanism for the user to easily specify histogram options on a per-plot basis.
HIST_OPTS="Histogram.PlotOpts.special"

OUTDD="$OUTD/GGP"
mkdir -p $OUTDD

# The flagstat data file contains pre-calculated statistics about BAM partly obtained from
# the BAM's flagstat file.
# For normalizing read depth, we use number of mapped reads and read length 
# normalize read depth by num_reads * bp_per_read / (2 * num_reads_in_genome)
FLAGSTAT="$DATD_DEP/TCGA_Virus.flagstat.dat"


# This code also in T_AssembleBPS/1_drawBreakpointPlots.sh
VIRUS_DICT="$BPS_DATA/M_Reference/dat/virus_names.dat"
function rename_chrom {
    OLDN=$1

    # Make nicer names.  Remap virus code to virus name using database below.
    # if not in database, assume chrom name, and append "Chr" prefix
    # template:
    if grep -q "^$OLDN" $VIRUS_DICT; then
        NEWN=`grep "^$OLDN" $VIRUS_DICT | cut -f 2 -d ' '`
    else
        NEWN="Chr.$OLDN"
    fi

    echo $NEWN
}

function process_chrom {
    BAR=$1
    NAME=$2
    A_CHROM=$3
    B_CHROM=$4

#    if [ $FLIPAB == 1 ]; then    # defined in ../bps.config
#        DEPB="$DATD_DEP/${BAR}/${NAME}.A.${FLANKN}.DEPTH.dat"
#        DEPA="$DATD_DEP/${BAR}/${NAME}.B.${FLANKN}.DEPTH.dat"
#        LABELS="-e $B_CHROM,$A_CHROM"
#    else
        DEPA="$DATD_DEP/${BAR}/${NAME}.A.${FLANKN}.DEPTH.dat"
        DEPB="$DATD_DEP/${BAR}/${NAME}.B.${FLANKN}.DEPTH.dat"
        LABELS="-e $A_CHROM,$B_CHROM"
#    fi

    # barcode	filesize	read_length	reads_total	reads_mapped
    # TCGA-DX-A1KU-01A-32D-A24N-09	163051085994	100	2042574546	1968492930
    NUMREADS=`grep $BAR $FLAGSTAT | cut -f 5`  # using number of mapped reads
    READLEN=`grep $BAR $FLAGSTAT | cut -f 3`
    # TODO: deal gracefully if numreads, readlen unknown.

    # if histogram options file defined and histogram max range is set, define HISTMAX accordingly
    HISTMAX=""
    if [ -f $HIST_OPTS ]; then
        HM=`grep $NAME $HIST_OPTS | sed 's/#.*$//' | cut -f 2`
        if [ -n $HISTMAX ]; then    # if value not defined then set to default value
            HISTMAX="-m $HM"
        fi
    fi

    OUTDDD="$OUTDD/$BAR"
    mkdir -p $OUTDDD
    OUT="$OUTDDD/${NAME}.${FLANKN}.histogram.ggp"

    ARGS="-d -u $NUMREADS -n $READLEN $LABELS"

    Rscript $BIN $ARGS $DEPA $DEPB $OUT
}

while read l; do  

# Skip comments and header
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# extract sample names
BAR=`echo "$l" | cut -f 1`
NAME=`echo "$l" | cut -f 2`     # NAME is unique per integration event and should be used for all filenames

A_CHROM=`echo "$l" | cut -f 3`
B_CHROM=`echo "$l" | cut -f 8`

# For legend, rename chrom names to something more reader friendly
A_CHROM=$(rename_chrom $A_CHROM)
B_CHROM=$(rename_chrom $B_CHROM)

#echo Processing $NAME
process_chrom $BAR $NAME $A_CHROM $B_CHROM


done < $PLOT_LIST

