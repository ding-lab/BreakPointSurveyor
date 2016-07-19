# Paths to SAM files containing discordant reads

source ./Project.config

OUT="$OUTD/sam.dat"

# turns out it is easier to assign the data by hand here.

echo -e "barcode\tSAM" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
TCGA-BA-4077-01B-01D-2268-08 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Normals/SAM/discordant_TCGA-BA-4077-01B-01D-2268-08.sam
TCGA-BT-A20V-01A-11D-A14W-08 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Normals/SAM/discordant_TCGA-BT-A20V-01A-11D-A14W-08.sam
TCGA-CR-7385-01A-11D-2268-08 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Normals/SAM/discordant_TCGA-CR-7385-01A-11D-2268-08.sam
TCGA-CV-5971-01A-11D-1681-02 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Normals/SAM/discordant_TCGA-CV-5971-01A-11D-1681-02.sam
TCGA-FD-A3B4-01A-12D-A204-02 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Normals/SAM/discordant_TCGA-FD-A3B4-01A-12D-A204-02.sam
EOF

echo Written to $OUT
