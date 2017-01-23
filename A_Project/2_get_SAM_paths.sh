# Paths to SAM files containing discordant reads

source ./Project.config

OUT="$OUTD/sam.dat"

# turns out it is easier to assign the data by hand here.

# TODO: provide scripts which generate .sam files from realigned BAM

echo -e "barcode\tSAM" > $OUT
cat <<EOF | sort | tr ' ' '\t' >> $OUT
TCGA-BA-4077-01B-01D-2268-08 /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/discordant_pair/WGS/Normals/SAM/discordant_TCGA-BA-4077-01B-01D-2268-08.sam
EOF

echo Written to $OUT
