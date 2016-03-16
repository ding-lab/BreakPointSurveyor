# Download PlotList and CTX data.  This is used if calculations performed on different system than plotting.

function get_CTX_PlotList {
    TAR="CTX.tar.gz"
    SRC="linus300:/gscuser/mwyczalk/projects/TCGA_SARC/TCGA_SARC.bps/B_PlotList/tar/$TAR"
    scp $SRC .
    tar -zxf $TAR
    mkdir origdata
    mv $TAR origdata

    echo $TAR expanded and moved to origdata
}

get_CTX_PlotList
