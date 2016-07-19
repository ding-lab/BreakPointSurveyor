# Reusing data from prior Pindel runs
# See here for example of workflow with actual Pindel runs

source ./PindelRP.config
OUT="$OUTD/TCGA_Virus.Pindel_RP.dat"

echo -e "barcode\tRP_path" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
TCGA-BA-4077-01B-01D-2268-08 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Pindel/output/TCGA-BA-4077-01B-01D-2268-08_RP
TCGA-BT-A20V-01A-11D-A14W-08 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Pindel/output/TCGA-BT-A20V-01A-11D-A14W-08_RP
TCGA-CR-7385-01A-11D-2268-08 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Pindel/output/TCGA-CR-7385-01A-11D-2268-08_RP
TCGA-CV-5971-01A-11D-1681-02 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Pindel/output/TCGA-CV-5971-01A-11D-1681-02_RP
TCGA-FD-A3B4-01A-12D-A204-02 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Pindel/output/TCGA-FD-A3B4-01A-12D-A204-02_RP
EOF

echo Written to $OUT
