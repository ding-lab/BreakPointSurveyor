# Obtain FAI file. (Details: https://www.biostars.org/p/11523/#11524 )

source ./M_Reference.config

# process GRCh37
function define_37 {
SRC="/gscmnt/ams1102/info/model_data/2869585698/build106942997/all_sequences.fa.fai"
OUT="$OUTD/GRCh37-lite.fa.fai"
}

# process GRCh38
function define_38 {
SRC="/gscmnt/gc2508/dinglab/1000g_svtrios/reference/GRCh38_full_analysis_set_plus_decoy_hla.fa.fai"
OUT="$OUTD/GRCh38-full.fa.fai"
}

# define_37
define_38

scp linus300:$SRC $OUT
echo Written to $OUT
