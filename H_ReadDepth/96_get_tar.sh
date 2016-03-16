# Download DEPTH data.  This is used if depth calculations performed on different system than plotting.

TAR="DEPTH.tar.gz"
SRC="/gscuser/mwyczalk/projects/TCGA_SARC/TCGA_SARC.bps/H_ReadDepth/tar/$TAR"

scp linus300:$SRC .
tar -zxf $TAR
mkdir origdata
mv $TAR origdata

echo $TAR expanded and moved to origdata
