# Make a list of all DDLS SARC WGS tumor samples, their BAM paths, and model IDs

DATD="/gscmnt/gc2510/dinglab/rmashl/1000g_svtrios_runs/pindel/genomes"

mkdir -p dat
OUT="dat/1000SV.bam_path.dat"

rm -f $OUT

for BAM in `ls $DATD/*.bam`; do
    BAR=`basename $BAM | cut -f 1 -d.`
    echo -e "${BAR}\t${BAM}" >> $OUT
done

echo Written to $OUT
