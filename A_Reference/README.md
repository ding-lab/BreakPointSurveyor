# Reference

*Construct Human + Virus reference*

The "GRCh37_selectVirus_9a" human+virus reference used for TCGA-Virus alignment is a concatenation of the human genome (GRCh37) and 
18 virus sequences.  Source and details of human and virus sequences are listed below:

* [GRCh37-lite information](http://genome.wustl.edu/pub/reference/GRCh37-lite/README.txt)
* [HPV 6 (NC_001355.1)](http://www.ncbi.nlm.nih.gov/nuccore/NC_001355.1?report=genbank&log$=seqview)
* [HPV 16 (NC_001526.2)](http://www.ncbi.nlm.nih.gov/nuccore/NC_001526.2?report=genbank&log$=seqview)
* [HPV 18 (NC_001357.1)](http://www.ncbi.nlm.nih.gov/nuccore/NC_001357.1?report=genbank&log$=seqview)
* [HPV 31 (J04353.1/PPH31A)](http://www.ncbi.nlm.nih.gov/nuccore/J04353.1/PPH31A?report=genbank&log$=seqview)
* [HPV 33 (M12732.1/PPH33CG)](http://www.ncbi.nlm.nih.gov/nuccore/M12732.1/PPH33CG?report=genbank&log$=seqview)
* [HPV 35 (M74117.1)](http://www.ncbi.nlm.nih.gov/nuccore/M74117.1?report=genbank&log$=seqview)
* [HPV 39 (M62849.1/PPHT39)](http://www.ncbi.nlm.nih.gov/nuccore/M62849.1/PPHT39?report=genbank&log$=seqview)
* [HPV 45 (EF202167.1)](http://www.ncbi.nlm.nih.gov/nuccore/EF202167.1?report=genbank&log$=seqview)
* [HPV 52 (X74481.1)](http://www.ncbi.nlm.nih.gov/nuccore/X74481.1?report=genbank&log$=seqview)
* [HPV 56 (EF177177.1)](http://www.ncbi.nlm.nih.gov/nuccore/EF177177.1?report=genbank&log$=seqview)
* [HPV 58 (D90400.1/PPH58)](http://www.ncbi.nlm.nih.gov/nuccore/D90400.1/PPH58?report=genbank&log$=seqview)
* [HPV 59 (X77858.1)](http://www.ncbi.nlm.nih.gov/nuccore/X77858.1?report=genbank&log$=seqview)
* [BK Polyoma (NC_001538.1)](http://www.ncbi.nlm.nih.gov/nuccore/NC_001538.1?report=genbank&log$=seqview)
* [HHV 1 (JQ780693.1)](http://www.ncbi.nlm.nih.gov/nuccore/JQ780693.1?report=genbank&log$=seqview)
* [HHV 4 (NC_009334.1)](http://www.ncbi.nlm.nih.gov/nuccore/NC_009334.1?report=genbank&log$=seqview)
* [HHV 5 (AY446894.2)](http://www.ncbi.nlm.nih.gov/nuccore/AY446894.2?report=genbank&log$=seqview)
* [Hepatitis B (NC_003977.1)](http://www.ncbi.nlm.nih.gov/nuccore/NC_003977.1?report=genbank&log$=seqview)
* [Polyomavirus HPyV7 (NC_014407.1)](http://www.ncbi.nlm.nih.gov/nuccore/NC_014407.1?report=genbank&log$=seqview)

The combined reference is too large to distribute, but the index file [dat/GRCh37_selectVirus_9a.fa.fai](dat/GRCh37_selectVirus_9a.fa.fai)
is available.

Realignment was performed using BWA v. 0.5.9 with parameters `-t 4 -q 5::`
