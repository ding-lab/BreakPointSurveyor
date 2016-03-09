# Create histograms for manuscript
# there is no chrom.all plotted

DATD="../A_Data/origdata"

PLOT_LIST="$DATD/BP/PlotList.BPS.50K.dat"
BIN="/Users/mwyczalk/Data/TCGA_SARC/ICGC/BreakpointSurveyor/F_ReadDepth/src/HistogramCruncher.R"

# Histogram options are defined in the file below.  Only hist.max is currently supported.
# This is a mechanism for the user to easily specify histogram options on a per-plot basis.
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

DEP_0K="$DATD/origdata/DEPTH/${BAR}_0_depth.dat"
DEP_ALL="$DATD/origdata/DEPTH/${BAR}_All_depth.dat"
DEP_VIR="$DATD/origdata/DEPTH/${BAR}_virus_depth.dat"

READS="$DATD/origdata/read_count_map.dat"

# The read_count_map file contains pre-calculated statistics about BAM partly obtained from
# the BAM's flagstat file.
# For normalizing read depth, we use number of mapped reads and read length 
#   normalize read depth by reads_mapped * read_length / num_reads_in_genome
#
# barcode	analysis	reads_total	reads_mapped	read_length
# TCGA-AK-3455-01A-01D-2233-10	WGS	990044820	943303610	101
NUMREADS=`grep $BAR $READS | cut -f 4`
READLEN=`grep $BAR $READS | cut -f 5`

HISTMAX=`grep $NAME $HIST_OPTS | sed 's/#.*$//' | cut -f 2`
if [ -z $HISTMAX ]; then    # if value not defined then set to default value
    HISTMAX="NA"
fi

OUT="$OUTD/${NAME}.histogram.special.ggp"

ARGS=" \
-n $NUMREADS \
-l $READLEN \
-a $INT_START \
-b $INT_END \
-c $CHROM \
-m $HISTMAX \
-N 100
"
# -n is normally 100

# Usage: Rscript HistogramCruncher.R [-v] [-n num.reads] [-l read.length] [-N nbin] [-m hist.max] [-a range.start] [-b range.end] [-c chrom] chrom.depth.0.fn chrom.depth.all.fn virus.depth.all.fn histogram.ggp
Rscript $BIN -s -d $ARGS $DEP_0K $DEP_ALL $DEP_VIR $OUT

done < $PLOT_LIST

