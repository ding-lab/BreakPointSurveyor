# create two GGP for every row in PlotList
FLANKN="50K"
DATD="../A_Data/origdata"
PLOT_LIST="../B_PlotList/dat/Combined.PlotList.${FLANKN}.dat"

BIN="/Users/mwyczalk/Data/BreakpointSurveyor/BreakpointSurveyor/src/plot/HistogramRenderer.R"

# Histogram options are defined in the file below.  Only hist.max is currently supported.
# This is a mechanism for the user to easily specify histogram options on a per-plot basis.
# not currently implemented
HIST_OPTS="Histogram.PlotOpts.special"

OUTD="GGP"
mkdir -p $OUTD

while read l; do  
# name	barcode	disease	virus	chrom	integration.start	integration.end	range.start	range.end
# TCGA-BA-4077-01B-01D-2268-08.chr14A	TCGA-BA-4077-01B-01D-2268-08	HNSC	HPV16	14	68683065	68742035	68633064	68792035

# Skip comments and header
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# extract sample names
NAME=`echo "$l" | cut -f 2`     # NAME is unique per integration event and should be used for all filenames
BAR=`echo "$l" | cut -f 1`
VIR=`echo "$l "| cut -f 4`
CHROM=`echo "$l "| cut -f 5`
INT_START=`echo "$l" | cut -f 6`
INT_END=`echo "$l" | cut -f 7`

#echo Processing $NAME

DEPA="../C_ReadDepth/DEPTH/${BAR}/${NAME}.A.${FLANKN}.DEPTH.dat"
DEPB="../C_ReadDepth/DEPTH/${BAR}/${NAME}.B.${FLANKN}.DEPTH.dat"

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


# if histogram options file defined and histogram max range is set, define HISTMAX accordingly
HISTMAX=""
if [ -f $HIST_OPTS ]; then
    HM=`grep $NAME $HIST_OPTS | sed 's/#.*$//' | cut -f 2`
    if [ -n $HISTMAX ]; then    # if value not defined then set to default value
        HISTMAX="-m $HM"
    fi
fi

OUTDD="$OUTD/$BAR"
mkdir -p $OUTDD
OUT="$OUTDD/${NAME}.${FLANKN}.histogram.ggp"

# ARGS=" -n $NUMREADS -l $READLEN $HISTMAX -N 100 "
ARGS="-d"

# Usage: Rscript HistogramRenderer.R [-v] [-n num.reads] [-l read.length] [-N nbin] [-m hist.max] [-d] [-P]
#       depth.A.fn depth.B.fn out.ggp

Rscript $BIN $ARGS $DEPA $DEPB $OUT
exit

done < $PLOT_LIST

