source ./BPS_Stage.config

# Download the GRCh38 human reference and/or related files.  Note the reference is relatively large
SRC=ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome

U_OUTD=dat.untracked
mkdir -p $U_OUTD

function download {
DAT=$1
pushd $U_OUTD
wget $SRC/$DAT
#gunzip $DAT
popd $U_OUTD
}

# downloading the full reference for testing purposes
# Also download the .fai file to the untracked directory, so that appending .fai to reference works.
# Note that this means we have two copies of .fai file (dat, dat.untracked), but for now that's OK
download GRCh38_full_analysis_set_plus_decoy_hla.fa
download GRCh38_full_analysis_set_plus_decoy_hla.fa.fai
