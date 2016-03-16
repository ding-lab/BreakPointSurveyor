# Get translocation breakpoints from somatic variation
# file format: https://gscweb.gsc.wustl.edu/mediawiki/index.php/Filespec/BreakDancer

# Somatic variation paths for all samples of interest are in column 3 of,
# ../A_Project/dat/TCGA_SARC.samples.dat

# Writes dat/BAR.BPC.dat for each barcode

mkdir -p dat
DATA_LIST="../A_Project/dat/TCGA_SARC.samples.dat"

while read l; do
# barcode bam_path    CTX_path
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue


# first we write BPC file - this has all breakpoint coordinates listed just once.
#    BPC: chromA, posA, chromB, posB

BAR=`echo $l | awk '{print $1}'`
VAR_FN=`echo $l | awk '{print $3}'`

OUT="dat/${BAR}.CTX.BPC.dat"

# (we cast chrom name into string with $1"" so that string comparison is used)
grep CTX $VAR_FN | awk 'BEGIN{FS="\t";OFS="\t"}{if ($1"" <= $4"") print $1,$2,$4,$5; else print $4,$5,$1,$2}' | sort > $OUT
echo Written to $OUT

done < $DATA_LIST

