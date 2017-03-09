# Reusing data from prior Pindel runs
# For now, just copy data from old run and create Pindel_RP.dat file listing these

# Once data exist in dat/RP, this need not be run again

source ./PindelRP.config

DAT="/gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Pindel/output/TCGA-BA-4077-01B-01D-2268-08_RP"
OUTDD="$OUTD/RP"
mkdir -p $OUTDD

cp $DAT $OUTDD

# Now create a list of all existing pindel output.  
OUT="$OUTD/Pindel_RP.dat"

echo -e "barcode\tRP_path" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
TCGA-BA-4077-01B-01D-2268-08 $OUTDD/TCGA-BA-4077-01B-01D-2268-08_RP
EOF

echo Written to $OUT
