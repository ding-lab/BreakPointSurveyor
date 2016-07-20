# Run Tigra-SV on all samples of interest.
# Support provided for cluster queuing system (bsub)

# Tigra version used is 0.4.2; see https://bitbucket.org/xianfan/tigra

BIN="/gscuser/mwyczalk/src/tigra-0.4.2/tigra/tigra-sv"
# Tigra_sv version-0.4.2
# Arguments:
# 
# ./tigra_sv [options] <SV file> [<a.bam> <b.bam> ...]
# 
# 
# Options:
#     -l INT  Assembly [500] bp from the SV breakpoints
#     -a INT  Assembly [50] bp into the SV breakpoints
#     -k STR  Comma separated list of kmers [15,25]
#     -c STR  Only assemble calls on chromosome [STR]
#     -o FILE Save assembly contigs to [FILE]
#     -s INT  Only output contigs longer than [50] bp
#     -R FILE Path to the wildtype reference fasta
#     -r FILE Create pair-wise local reference sequence fastas in [FILE]
#     -w INT  Pad local reference by additional [200] bp on both ends
#     -q INT  Only assemble reads with mapping quality > [1]
#     -N INT  Highlight segments supported by SVReads that differ from reference by at least [5] mismatches
#     -p INT  Ignore cases that have average read depth greater than [10000]
#     -d  Dump reads by case into fasta files
#     -I STR  Save reads fasta into an existing directory
#     -b  The input file is in breakdancer format
#     -f  Provide a text file containing rows of sample:bam mapping
#     -M INT  Skip SVs shorter than [3] bp
#     -h INT  Skip complex contig graphs with more than [100] nodes
#     -m      Add mate for assembly, speed might be twice slower when this option is on.
#     -S STR  Spec_file:Read_file from the last run with -d turned on. Facilitates quick debug without extracting reads from bam. Spec_file is in the format of stderr.
# Version: 0.4.2

DAT="$OUTD/../A_Project/TCGA_Virus.samples.dat"
mkdir -p bsub

while read l; do  # iterate over all rows of TigraList.dat
# barcode	BAMpath	RPpath	REFpath	batch
# TCGA-BA-4077-01B-01D-1431-02	...d436.bam	.../TCGA-BA-4077-01B-01D-1431-02_RP	.../all_sequences.fa	Normals.9a

# Skip comments and header
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

BAR=`echo $l | awk '{print $1}'`
BAM=`echo $l | awk '{print $2}'`
FASTA=`echo $l | awk '{print $4}'`

CTX="CTX/${BAR}.ctx"
OUT="$OUTD/${BAR}.contig"

if [ -e $OUT ]; then
echo $OUT exists.  Skipping.
continue
fi

# adding -m flag, supported under 0.4.2
CMD="$BIN -o $OUT -R $FASTA -b $CTX -m $BAM"
# below if not using -m
#CMD="$BIN -o $OUT -R $FASTA -b $CTX $BAM"

bsub -oo bsub/$BAR.bsub $CMD   # this is functional

done < $DAT
