# GRCh37-lite .fai file:
REF="/gscmnt/sata420/info/model_data/2857786885/build102671028/all_sequences.fa.fai"

BIN="../../BreakpointSurveyor/src/util/makeBreakpointRegions.py"

# Create BPR file which has regions of breakpoint events.
# Such events are in the context of unique chromA/chromB pairs, so we process each of these pairs individually.
# Combine into one region all breakpoints on chrom A as well as those on chrom B
# which are within a distance of D from each other along both chromosomes.

# writing all output per sample to dat/*combined.BPR

# Combine all events 5Mbp of each other
D=5000000
set +o posix

DATA_LIST="../A_DataPaths/dat/SARC_DDLS.somatic_variation.dat"

while read l; do  # iterate over all barcodes

BAR=`echo $l | awk '{print $1}'`
DAT="dat/$BAR.BPC.dat"

OUT="dat/${BAR}.combined.BPR.dat"
rm -f $OUT

# Iterate over all unique chromA, chromB pairs in each sample
while read m; do

CHROMA=`echo $m | awk '{print $1}'`
CHROMB=`echo $m | awk '{print $2}'`

# process chrom

python $BIN -A $CHROMA -B $CHROMB -R $D $DAT stdout  >> $OUT

done < <(cut -f 1,3 $DAT | sort -u)

echo Written to $OUT

done < $DATA_LIST  # iterate over all barcodes
