BIN="/Users/mwyczalk/src/BreakpointSurveyor/BreakpointSurveyor/src/util/processVCF.py"
mkdir -p dat

HEADER=""
OUT="dat/SVTrio.TRA.bpc"
rm -f $OUT

for S in NA19238 NA19239 NA19240 ; do

DAT="origdata/${S}.alt_bwamem_GRCh38DH.20150715.YRI.high_coverage.cram_TRA_filter.vcf"

python $BIN $HEADER -a $S -i $DAT bpc >> $OUT
HEADER="-H"

done

echo Written to $OUT


