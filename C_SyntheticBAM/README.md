# Project
*Construct a synthetic BAM to demonstrate simple breakpoint*

1. Download two segments of the [GRCh38 human genome](http://genome.ucsc.edu/cgi-bin/das/hg19/dna)
    * Segment 1: chr9:130,840,000-130,850,000
    * Segment 2: chr22:23,260,000-23,270,000

   Extract the sequences and concatenate them.  This requires Perl library `XML::XPath`
2. Use `wgsim` (distributed with samtools) to generate synthetic (simulated) reads
   against this concatenated sequence.  Aiming for 80X coverage of 126bp reads (like 1000SV data)
3. Use `BWA` to realign these reads to a reference which contains chr9 and chr22.  This then generates
   a BAM file which will be analyzed in subsequent workflows
4. Write `BPS.samples.dat`

## Performance
`3_realign.sh` takes about 10 sec.
