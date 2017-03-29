#Reference
*Construct Human + Virus reference*

**TODO** Clean up documentation, explain origin of Human + Virus reference.  Not kept here except for .fai file

Contents here:

* TODO: Bring in FAI for human+virus reference here from GSC

Source of `dat/GRCh37_selectVirus_9a.fa.fai`:
linus301.gsc.wustl.edu:/home/archive/mwyczalk/BreakPointSurveyor.TCGA_Data/GRCh37-lite-+-selected-virus-2013.9.a/all_sequences.fa.fai

Source of `dat/selectedVirus_2013.9a.bed`:
TODO

We currently do not construct the reference here, but notes for doing it are below.

[GRCh37-lite information](http://genome.wustl.edu/pub/reference/GRCh37-lite/README.txt)

ftp://genome.wustl.edu/pub/reference/GRCh37-lite/GRCh37-lite.fa.gz

Old notes below from `/gscuser/mwyczalk/projects/Virus/Virus_2013.9a/Reference`

```
1) map_fasta.sh
This creates the index files All_HPV_Headers.dat and All_Viral_Headers.dat, which are used to extract the fastas we want

2) find_references.sh
This finds the viruses we want in the above index files.  Output of this is then used to create the file...

3) get_FASTAs.sh
Manually created to use SED to extract the FASTAs we want from the whole references.
When executed, creates a bunch of FASTAs in the FASTA directory.

4) Get Kristine's FASTAs

ln -s /gscmnt/gc4019/research/HMP_2010/kwylie/CANCER_SNPS/BK_POLYOMAVIRUS_REFERENCE FASTAs/BK.fa
ln -s /gscmnt/gc4019/research/HMP_2010/kwylie/CANCER_SNPS/HSV1_REFERENCE  FASTAs/HHV.fa
ln -s /gscmnt/gc4019/research/HMP_2010/kwylie/CANCER_SNPS/HHV5_MERLIN_REFERENCE  FASTAs/HHV5.fa

5) cat FASTAs/* > SelectVirusReference.fa
made sure blank lines between entries.

5b) gmt picard normalize-fasta --input=SelectVirusReference.fa --output=SelectVirusReferenceNorm.fa

6) create_reference_model.sh
Name: "GRCh37-lite + selected virus 2013.9.a"
Based on projects/Virus/RNA-Seq/BLCA/BAM/build/create_references.sh
Create a reference model to be used for further reference alignments.
Reference imported. ID: <922230c747f14d288b8e73ca81d18a04>, data_directory: </gscmnt/gc9008/info/model_data/881e20d5404b453ea61632130577130c/build922230c747f14d288b8e73ca81d18a04>.

-----
Creating SelectVirusReferenceNorm.2013.10.a.fa.fai with,
    samtools faidx SelectVirusReferenceNorm.2013.10.a.fa
```
