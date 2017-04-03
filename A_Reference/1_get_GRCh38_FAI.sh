source ./BPS_Stage.config

SRC=ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome

function download {
DAT=$1
pushd $OUTD
wget $SRC/$DAT
#gunzip $DAT
popd $OUTD
}


# downloading the full reference may not be necessary ...
# download GRCh38_full_analysis_set_plus_decoy_hla.fa

download GRCh38_full_analysis_set_plus_decoy_hla.fa.fai
