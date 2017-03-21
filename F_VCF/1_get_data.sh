

source ./VCF.config

# Download select 1000G VCF 

SRC=ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502
# ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr13.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz

function download {
    DAT=$1
    pushd $OUTD
    wget $SRC/$DAT
    #gunzip $DAT
    popd $OUTD
}


download ALL.chr13.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
download ALL.chr13.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz.tbi
