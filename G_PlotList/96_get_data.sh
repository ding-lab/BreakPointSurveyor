# Download PlotList.  This script is used if upstream calculations performed on different system than plotting.

function get_PlotList {
    SRC="linus300:/gscuser/mwyczalk/projects/TCGA_SARC/TCGA_SARC.bps/G_PlotList/dat/TCGA_SARC.PlotList.50K.dat"
    mkdir -p dat
    scp $SRC dat
}

get_PlotList
