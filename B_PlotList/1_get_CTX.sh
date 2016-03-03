# Get translocation breakpoints from somatic variation
# file format: https://gscweb.gsc.wustl.edu/mediawiki/index.php/Filespec/BreakDancer

# Somatic variation paths for all samples of interest are here:
# /gscuser/mwyczalk/projects/TCGA_SARC/A_Data/dat/SARC_DDLS.somatic_variation.dat
# for the time being, we'll just focus on the first one:
# TCGA-DX-A1KW-01A-22D-A24N-09    /gscmnt/gc12001/info/model_data/19d60b23a3db4a78a29952e374eb20d2/build00c4eeb2a00e42df9cb1b349396278bf

#set +o posix
mkdir -p dat
DIR="/gscmnt/gc12001/info/model_data/19d60b23a3db4a78a29952e374eb20d2/build00c4eeb2a00e42df9cb1b349396278bf"

# first we write BPC file - this has all breakpoint coordinates listed just once.
#    BPC: chromA, posA, chromB, posB

BAR="TCGA-DX-A1KW-01A-22D-A24N-09"

DAT="$DIR/variants/svs.hq"

OUT="dat/${BAR}.BPC.dat"

# (we cast chrom name into string with $1"" so that string comparison is used)
grep CTX $DAT | awk 'BEGIN{FS="\t";OFS="\t"}{if ($1"" <= $4"") print $1,$2,$4,$5; else print $4,$5,$1,$2}' | sort > $OUT
echo Written to $OUT

