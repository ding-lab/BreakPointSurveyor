source ./BPS_Stage.config

mkdir dat.untracked

pushd dat.untracked

S="http://gdac.broadinstitute.org/runs/stddata__2016_01_28/data/HNSC/20160128"
F="gdac.broadinstitute.org_HNSC.Merge_rnaseqv2__illuminahiseq_rnaseqv2__unc_edu__Level_3__exon_quantification__data.Level_3.2016012800.0.0.tar.gz"
wget $S/$F
ln -s $F HNSC.RSEM.tar.gz
chmod 444 $F

popd
