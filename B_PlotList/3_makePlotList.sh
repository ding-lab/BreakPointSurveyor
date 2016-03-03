# Create a PlotList.BPS data file for Breakpoint Surveyor plots

# PlotList is TSV format with the following columns,
#  * barcode
#  * event.name (unique)
#  * chrom.a, (first chromosome of coordinate pair)
#  * event.a.start, event.a.end (indicates region of e.g. SV event)
#  * range.a.start, range.a.end (indicates region to plot; calculated as event.start - context, event.end + context, respectively)
#  * chrom.b, (second chromosome of coordiante pair)
#  * event.b.start, event.b.end, range.b.start, range.b.end 

# A PlotList file lists all SV events which are to be plotted, with one plot per line.
# For SVs, we have the positions of the event on Chrom A and B, as well as the "range" for
# both chromosomes.  The range sets the limits of the plots, and is often +/- 50Kbp around
# the event.

# We have the option of collecting all plots for all samples into one PlotList file,
# or keep PlotList files per-sample.  For now, doing the latter, and concatenate them
# in the subsequent step

REF="/gscmnt/gc13011/info/model_data/af2f9fd499974fa89ebd3e39b184bfc9/build3e4b15f219de4a50bf1ab67702ae54eb/all_sequences.fa.fai"
BIN="../../BreakpointSurveyor/src/util/PlotListMaker.py"

OUTD="dat"
mkdir -p $OUTD
DATD="../A_Data/origdata"

FLANK="50000"  # distance around each integration region to be included in BED file

OUT="$OUTD/Combined.PlotList.50K.dat"
rm -f $OUT

DATA_LIST="../A_DataPaths/dat/SARC_DDLS.somatic_variation.dat"
while read l; do  # iterate over all barcodes

# when looping around multiple barcodes, combine them all into one output file
BAR=`echo $l | awk '{print $1}'`

DAT="dat/${BAR}.combined.BPR.dat"
#OUT="$OUTD/$BAR.PlotList.50K.dat"

# python $BIN -s 3 -c $FLANK -i $DAT -o $OUT -r $REF -n $BAR  # this if writing per-barcode
python $BIN -s 3 -c $FLANK -i $DAT -o stdout -r $REF -n $BAR >> $OUT

echo Written to $OUT
done < $DATA_LIST  # iterate over all barcodes
