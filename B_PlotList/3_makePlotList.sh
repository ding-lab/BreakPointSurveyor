# Create a PlotList.BPS data file for Breakpoint Surveyor plots
# A PlotList file lists all SV events which are to be plotted, with one plot generated per line
# For SVs, we plot a range of chrom A on one axis and a range of chrom B on the other; chrom A and B may be the same, and one may correspond to a virus.
# The PlotList also contains the range of the plot (classically +/- 50Kbp "flank" around
# the integration site); this range is used for filtering input data and typically
# the xlim, ylim of subplots.

OUTD="dat"
mkdir -p $OUTD
DATD="../A_Data/origdata"

OUT="$OUTD/PlotList.BPS.50K.dat"
REF="/gscmnt/gc13011/info/model_data/af2f9fd499974fa89ebd3e39b184bfc9/build3e4b15f219de4a50bf1ab67702ae54eb/all_sequences.fa.fai"
FLANK="50000"  # distance around each integration region to be included in BED file

# if looping around multiple barcodes, combine them all into one output file
BAR="TCGA-DX-A1KW-01A-22D-A24N-09"

DAT="dat/${BAR}.combined.BPR.dat"
#DAT="$DATD/BP/${BAR}.SVEvents.BPR.dat"

# Note that this will have to be run once for every barcode and then concatenated
BIN="../../src/PlotListMaker.py"
python $BIN -c $FLANK -i $DAT -o $OUT -r $REF -n $BAR

echo Written to $OUT
