# Create GGP object with read depth histogram

source ./DrawHistogram.config
FLANKN="50K"

DATD_DEP="$BPS_DATA/K_ReadDepth/dat"
DATD_PL="$BPS_DATA/J_PlotList/dat"
PLOT_LIST="$BPS_DATA/J_PlotList/dat/PlotList.${FLANKN}.dat"

BIN="$BPS_CORE/src/plot/HistogramDrawer.R"

# Histogram options are defined in the TSV file below.  
# This is a mechanism for the user to easily specify histogram max value on a per-plot basis.
HIST_OPTS="Histogram.PlotOpts.special"

OUTDD="$OUTD/GGP"
mkdir -p $OUTDD

# The flagstat data file contains pre-calculated statistics about BAM partly obtained from
# the BAM's flagstat file.
# For normalizing read depth, we use number of mapped reads and read length 
# normalize read depth by num_reads * bp_per_read / (2 * num_reads_in_genome)
FLAGSTAT="$DATD_DEP/flagstat.dat"

function process_chrom {
    BAR=$1
    NAME=$2
    A_CHROM=$3
    B_CHROM=$4

    DEPA="$DATD_DEP/${BAR}/${NAME}.A.${FLANKN}.DEPTH.dat"
    DEPB="$DATD_DEP/${BAR}/${NAME}.B.${FLANKN}.DEPTH.dat"
    LABELS="-e $A_CHROM,$B_CHROM"

    # barcode	filesize	read_length	reads_total	reads_mapped
    # TCGA-DX-A1KU-01A-32D-A24N-09	163051085994	100	2042574546	1968492930
    NUMREADS=`grep $BAR $FLAGSTAT | cut -f 5`  # using number of mapped reads
    READLEN=`grep $BAR $FLAGSTAT | cut -f 3`
    # TODO: deal gracefully if numreads, readlen unknown.

    # if histogram options file defined and histogram max range is set, define HISTMAX accordingly
    HISTMAX=""
    if [ -f $HIST_OPTS ]; then

        if grep -Fq $NAME $HIST_OPTS
        then
            HM=`grep $NAME $HIST_OPTS | sed 's/#.*$//' | cut -f 2`
            if [ -n $HISTMAX ]; then    # if value not defined then set to default value
                HISTMAX="-m $HM"
            fi
        fi
    fi

    OUTDDD="$OUTDD/$BAR"
    mkdir -p $OUTDDD
    OUT="$OUTDDD/${NAME}.${FLANKN}.histogram.ggp"

    ARGS="-d -u $NUMREADS -n $READLEN $LABELS $HISTMAX"

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

#echo Processing $NAME
process_chrom $BAR $NAME $A_CHROM $B_CHROM


done < $PLOT_LIST

