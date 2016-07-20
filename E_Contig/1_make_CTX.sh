# Create CTX configuration files for tigra-sv based on Pindel RP BPR data
#
# Creating tigra-sv CTX files from Pindel is undocumented.  This workflow 
# based on /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/preliminary/reanalyze/breakdancer/BA-4077.ctx, analysis of 
# tigra-sv code, and discussion with Kai Ye.
#
# One line from Pindel BPR is one line of tigra CTX input.  Use average from Pindel positions for CTX position.
#   Note that we could use Pindel RP directly, but will read BPR file since that performs filtering and normalization of breakpoints

source ./Contig.config
#OUT="$OUTD/TCGA_Virus.Pindel_RP.dat"


DAT="$OUTD/../A_Project/TCGA_Virus.samples.dat"
mkdir -p $OUTD/CTX

while read l; do  # iterate over all rows of TCGA_Virus.samples.dat 
# barcode	BAMpath	RPpath	REFpath	batch
# TCGA-BA-4077-01B-01D-1431-02	...d436.bam	.../TCGA-BA-4077-01B-01D-1431-02_RP	.../all_sequences.fa	Normals.9a

# Skip comments and header
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

BAR=`echo $l | awk '{print $1}'`
RP=`echo $l | awk '{print $3}'`
OUT="CTX/${BAR}.ctx"

Rscript src/TigraCTXMaker.R $RP $OUT

done < $DAT
