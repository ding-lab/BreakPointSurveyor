# GRCh37-lite .fai file:
REF="/gscmnt/sata420/info/model_data/2857786885/build102671028/all_sequences.fa.fai"

# Create BPR file which has regions of breakpoint events.
# Such events are in the context of unique chromA/chromB pairs, so we process each of these pairs individually.
# Combine all breakpoints on chrom A as well as those on chrom B
# which are within a distance of RADIUS from each other into one region.  
RADIUS=25000000
#RADIUS=50000000
#RADIUS=49

set +o posix

BAR="TCGA-DX-A1KW-01A-22D-A24N-09"
DAT="dat/$BAR.BPC.dat"

# Iterate over all unique chromA, chromB pairs
while read l; do

CHROMA=`echo $l | awk '{print $1}'`
CHROMB=`echo $l | awk '{print $2}'`

#OUT="dat/${BAR}.chrom_${CHROMA}_${CHROMB}.BPR.dat"
OUT="dat/${BAR}.combined.BPR.dat"
# process chrom

python ../../src/makeBreakpointRegions.py -A $CHROMA -B $CHROMB -R $RADIUS $DAT stdout >> $OUT

done < <(cut -f 1,3 $DAT | sort -u)

echo Written to $OUT
