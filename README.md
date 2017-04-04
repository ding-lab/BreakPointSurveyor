# BPS.TCGA_Virus.Lite 
Sample BreakPoint Surveyor project.  Data for NA19240 human-human breakpoint

Focusing on two events:

"AQ" event: chr10:41854249-41915847	to chr20:31051980-31241883	
AQ is between chr10 and chr20, and has a discordant read signature which is frequently found: no pattern to discordant reads, and a spike in copy number (see histogram).  I haven’t confirmed, but this is probably anomalous mapping between two repetitive regions.

"AU" event: chr13:62947705-63061713	to chr17:221247350-22180085	
AU between chr13 and chr17 has a very different discordant read pattern, with the reads falling cleanly on a diagonal.  Chr13 has “gene” RP11-527N12.2 involved:

"RP11 is a code identifying an individual anonymous human donor to a The BAC
clone library started at Roswell Park Cancer Institute by Dr.Pieter de Jong.
Initially, samples were obtained from 10 men and 10 women. During the
processing of the samples, DNA from one individual (RP11) emerged as the best
quality most complete set and became the source for much of the BAC clone
library that much of the Human Gnome project studied. As new genes were
discovered and named, the names include the source info "RP11.”” (source:
[biostars](https://www.biostars.org/p/51456/))


Sequence data is publicly available NA19240 Illumina 80X coverage, [and can be downloaded here](ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/hgsv_sv_discovery/data/YRI/NA19240/high_cov_alignment/NA19240.alt_bwamem_GRCh38DH.20150715.YRI.high_coverage.cram).
We assume this dataset is locally available.  However, to make downstream
analysis faster, we construct a smaller dataset which includes reads only from
regions of interest.  See [C_Project](C_Project/README.md) for how to specify BAM file locations.
As a result, we loop over two different BAM files.

Performance:
Stage C_Project:128 sec
Stage G: 16 sec
Stage J: 13 minutes
Stage K: 55 sec
Stage N-T: 73 sec

## Usage
e.g., A_Project/1_...


## Documentation

**TODO** Add manuscript PDF

BPS.TCGA_Virus.Lite contains a series of directories, each of which implements
a stage in the BPS workflow. The order of processing indicated by the stage's letter prefix.  
In general, a given stage may depend on data generated by a preceding stage.
See [BreakPointSurveyor-Core](https://github.com/ding-lab/BreakPointSurveyor-Core) for additional details.

Below are stages associated with the TCGA_Virus.Lite workflow and their description:

* **[A_Reference](A_Reference/README.md)**: Reference-specific analysis and files.
* **[B_ExonGene](B_ExonGene/README.md)**: Generate exon and gene definitions files.
* **[C_Project](C_Project/README.md)**: Create list of BAMs, both realigned WGS and RNA-Seq.  Create BAMs in `Synthetic` branch.
* **[F_PindelRP](F_PindelRP/README.md)**: Run Pindel and process breakpoint predictions.
* **[G_Discordant](G_Discordant/README.md)**: Process realigned BAM file to extract discordant human-virus reads
* **[I_Contig](I_Contig/README.md)**: Create contigs using Tigra-SV and realign them
* **[J_PlotList](J_PlotList/README.md)**: Identify target regions for further processing and visualization
* **[K_ReadDepth](K_ReadDepth/README.md)**: Evaluate read depth in target regions, obtain BAM file statistics for both WGS and RNA-Seq data
* **[L_Expression](L_Expression/README.md)**: Analyze expression in vicinity of integration events using RNA-Seq data. (`master` branch only)
* **[M_RPKM_Expression](M_RPKM_Expression/README.md)**: Analyze expression in vicinity of integration events using TCGA RPKM data. (`master` branch only)
* **[N_DrawBreakpoint](N_DrawBreakpoint/README.md)** Plot breakpoint coordinates from various predictors to breakpoint panel GGP.
* **[O_DrawDepth](O_DrawDepth/README.md)** Create read depth/copy number panel GGP and add breakpoint predictions
* **[P_DrawAnnotation](P_DrawAnnotation/README.md)** Create annotation panel GGP showing genes and exons
* **[Q_DrawHistogram](Q_DrawHistogram/README.md)**: Create histogram panel GGP showing distribution of read depth
* **[T_PlotStructure](T_T_PlotStructure/README.md)**: Assemble GGP panels into BPS structure plot and save as PDF
* **[U_PlotExpression](U_PlotExpression/README.md)**: Create BPS Expression plot based on expression P-values and save as PDF (`master` branch only)

### Output

* [BreakPoint Surveyor Structure Plot](T_AssembleBPS/plots/TCGA-BA-4077-01B-01D-2268-08.AA.chr14.BreakpointSurvey.pdf)
* [BreakPoint Surveyor Expression Plot](U_RPKMBubble/plots/TCGA-BA-4077-01B-01D-2268-08.AA.chr14.FDR.bubble.pdf)


## Authors
Matthew A. Wyczalkowski, m.wyczalkowski@wustl.edu

## License
This software is licensed under the GNU General Public License v3.0

## Acknowledgements
