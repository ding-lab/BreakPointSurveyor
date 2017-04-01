# BPS.TCGA_Virus.Lite - Synthetic branch

Sample BreakPoint Surveyor project.  Data for synthetic human-human breakpoint

Idea here is to generate small BAM representing an interchromosomal translocation then
analyze it using BreakpointSurveyor.  Other sample examples may be added as necessary.

Three workflows are represented as git branches:

* `master`: Comprehensive workflow and data for one TCGA virus-positive sample (TCGA-BA-4077-01).
* `1000SV`: Example analysis of discordant reads on publicly available 1000 Genomes sample NA19420
* `Synthetic`: Create and analyze inter-chromosomal breakpoint

## Documentation

See [BreakPointSurveyor-Core](https://github.com/ding-lab/BreakPointSurveyor-Core/README.md) 
for background.

## Timing

Downloading and processing of two-chromosome reference (A_Reference) is about 5 minutes, uses about 684M
Total execution time for steps J-T about 15 seconds

### Output

** TODO ** fix link below
* [BreakPoint Surveyor Structure Plot](T_AssembleBPS/plots/TCGA-BA-4077-01B-01D-2268-08.AA.chr14.BreakpointSurvey.pdf)


## Authors
Matthew A. Wyczalkowski, m.wyczalkowski@wustl.edu

## License
This software is licensed under the GNU General Public License v3.0

## Acknowledgements
