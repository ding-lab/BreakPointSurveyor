# Reusing data from prior Pindel runs
# See here for example of workflow with actual Pindel runs

source ./Discordant.config
OUT="$OUTD/TCGA_Virus.Discordant.dat"

echo -e "barcode\tDiscordant_path" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
TCGA-BA-4077-01B-01D-2268-08 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Normals/SAM/discordant_TCGA-BA-4077-01B-01D-2268-08.sam
TCGA-BT-A20V-01A-11D-A14W-08 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Normals/SAM/discordant_TCGA-BT-A20V-01A-11D-A14W-08.sam
TCGA-CR-7385-01A-11D-2268-08 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Normals/SAM/discordant_TCGA-CR-7385-01A-11D-2268-08.sam
TCGA-CV-5971-01A-11D-1681-02 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Normals/SAM/discordant_TCGA-CV-5971-01A-11D-1681-02.sam
TCGA-FD-A3B4-01A-12D-A204-02 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Normals/SAM/discordant_TCGA-FD-A3B4-01A-12D-A204-02.sam
EOF

echo Written to $OUT
