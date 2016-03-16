# Get translocation breakpoints from somatic variation
# file format: https://gscweb.gsc.wustl.edu/mediawiki/index.php/Filespec/BreakDancer

# Somatic variation paths for all samples of interest are here:
# ../A_Data/dat/SARC_DDLS.somatic_variation.dat

#set +o posix
mkdir -p dat
DATA_LIST="../A_DataPaths/dat/SARC_DDLS.somatic_variation.dat"

while read l; do
# first we write BPC file - this has all breakpoint coordinates listed just once.
#    BPC: chromA, posA, chromB, posB

BAR=`echo $l | awk '{print $1}'`
DIR=`echo $l | awk '{print $2}'`

DAT="$DIR/variants/svs.hq"

OUT="dat/${BAR}.BPC.dat"

# (we cast chrom name into string with $1"" so that string comparison is used)
grep CTX $DAT | awk 'BEGIN{FS="\t";OFS="\t"}{if ($1"" <= $4"") print $1,$2,$4,$5; else print $4,$5,$1,$2}' | sort > $OUT
echo Written to $OUT

done < $DATA_LIST

