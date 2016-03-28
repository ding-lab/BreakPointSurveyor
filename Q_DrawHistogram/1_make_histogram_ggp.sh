# create two GGP for every row in PlotList
FLANKN="50K"

DATD_DEP="../H_ReadDepth/DEPTH"
DATD_PL="../G_PlotList/dat"
PLOT_LIST="$DATD_PL/TCGA_SARC.PlotList.${FLANKN}.dat"

BIN="/Users/mwyczalk/Data/BreakpointSurveyor/BreakpointSurveyor/src/plot/HistogramDrawer.R"

# Histogram options are defined in the file below.  Only hist.max is currently supported.
# This is a mechanism for the user to easily specify histogram options on a per-plot basis.
# not currently implemented
HIST_OPTS="Histogram.PlotOpts.special"

OUTD="GGP"
mkdir -p $OUTD

# The flagstat data file contains pre-calculated statistics about BAM partly obtained from
# the BAM's flagstat file.
# For normalizing read depth, we use number of mapped reads and read length 
# normalize read depth by num_reads * bp_per_read / (2 * num_reads_in_genome)
FLAGSTAT="$DATD_DEP/TCGA_SARC.flagstat.dat"

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

DEPA="$DATD_DEP/${BAR}/${NAME}.A.${FLANKN}.DEPTH.dat"
DEPB="$DATD_DEP/${BAR}/${NAME}.B.${FLANKN}.DEPTH.dat"

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

OUTDD="$OUTD/$BAR"
mkdir -p $OUTDD
OUT="$OUTDD/${NAME}.${FLANKN}.histogram.ggp"

# ARGS=" -n $NUMREADS -l $READLEN $HISTMAX -N 100 "
ARGS="-d -n $NUMREADS -l $READLEN "

# Usage: Rscript HistogramDrawer.R [-v] [-n num.reads] [-l read.length] [-N nbin] [-m hist.max] [-d] [-P]
#       depth.A.fn depth.B.fn out.ggp

Rscript $BIN $ARGS $DEPA $DEPB $OUT

done < $PLOT_LIST

