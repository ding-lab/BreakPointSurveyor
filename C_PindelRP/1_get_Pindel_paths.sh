# Reusing data from prior Pindel runs
# See here for example of workflow with actual Pindel runs

source ./PindelRP.config
OUT="$OUTD/TCGA_Virus.Pindel_RP.dat"

echo -e "barcode\tRP_path" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
TCGA-BA-4077-01B-01D-2268-08 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Pindel/output/TCGA-BA-4077-01B-01D-2268-08_RP
EOF

echo Written to $OUT
