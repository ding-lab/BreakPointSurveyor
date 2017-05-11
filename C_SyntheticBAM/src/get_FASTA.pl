#!/usr/bin/env perl

# Download segment of GRCh38 reference and extract FASTA
#
# Usage:
#    perl extract.pl chr2:100000,100100 > data.fa

# Based on https://www.biostars.org/p/6156/
# see also,
#   http://genome.ucsc.edu/FAQ/FAQdownloads.html#download23
#   http://biodas.open-bio.org/documents/spec-1.53.html

use strict;
use warnings;
use LWP::Simple;
use XML::XPath;
use XML::XPath::XMLParser;

#Use DAS of UCSC to fetch specific sequence by its given chromosome position

my $segment = shift;
print STDERR "Downloading $segment\n";

my $URL_gene ="http://genome.ucsc.edu/cgi-bin/das/hg19/dna?segment=$segment";

my $xml = get($URL_gene);

my $xp = XML::XPath->new(xml=>$xml);

my $nodeset = $xp->find('/DASDNA/SEQUENCE/DNA/text()'); # find all sequences
# there should be only one node, anyway:    
foreach my $node ($nodeset->get_nodelist) {
   my $seq = $node->getValue;
   $seq =~ s/\s//g; # remove white spaces
   print ">$segment\n";
   print uc $seq, "\n";
}

