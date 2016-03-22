# Obtain FAI file. (Details: https://www.biostars.org/p/11523/#11524 )

# Distributed with FAI file for GRCh37-lite-build37 reference
# /gscmnt/gc2508/dinglab/1000g_svtrios/reference/GRCh38_full_analysis_set_plus_decoy_hla.fa.fai
source ./M_Reference.config

# GRCh38
#SRC="/gscmnt/gc2508/dinglab/1000g_svtrios/reference/GRCh38_full_analysis_set_plus_decoy_hla.fa.fai"
#OUT="$OUTD/GRCh38-full.fa.fai"

# GRCh37
SRC="/gscmnt/ams1102/info/model_data/2869585698/build106942997/all_sequences.fa.fai"
OUT="$OUTD/GRCh37-lite.fa.fai"

function get_fai {
scp linus300:$SRC $OUT
}

get_fai
