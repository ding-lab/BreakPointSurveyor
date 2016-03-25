# Get translocation breakpoints from somatic variation
# file format: https://gscweb.gsc.wustl.edu/mediawiki/index.php/Filespec/BreakDancer

# CTX paths from column 3 of $BPS_DATA/A_Project/dat/1000SV.samples.dat

# Writes dat/BAR.BPC.dat for each barcode

source ./B_CTX.config

DATA_LIST="$BPS_DATA/A_Project/dat/1000SV.samples.dat"
echo Data list: $DATA_LIST

while read l; do
# barcode	bam_path	CTX_path	Pindel_path
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue


# first we write BPC file - this has all breakpoint coordinates listed just once.
#    BPC: chromA, posA, chromB, posB

BAR=`echo $l | awk '{print $1}'`
CTX_FN=`echo $l | awk '{print $3}'`   # read column 3

OUT="$OUTD/${BAR}.CTX.BPC.dat"

# (we cast chrom name into string with $1"" so that string comparison is used)
grep CTX $CTX_FN | awk 'BEGIN{FS="\t";OFS="\t"}{if ($1"" <= $4"") print $1,$2,$4,$5; else print $4,$5,$1,$2}' | sort > $OUT
echo Written to $OUT

done < $DATA_LIST

