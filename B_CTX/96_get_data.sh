# Download CTX BPC data.  This script is used if upstream calculations performed on different system than plotting.

function get_CTX {
    TAR="CTX.tar.gz"
    SRC="linus300:/gscuser/mwyczalk/projects/TCGA_SARC/TCGA_SARC.bps/B_CTX/tar/$TAR"
    scp $SRC .
    tar -zxf $TAR
    mkdir origdata
    mv $TAR origdata

    echo $TAR expanded and moved to origdata
}

get_CTX
