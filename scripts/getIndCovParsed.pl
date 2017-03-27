#!/usr/bin/perl

# Returns the number of reads for each individual. Use this after running the parse barcodes script.

# USAGE: perl getIndCov.pl parsedfile.fastq

$in = shift @ARGV;

open (IN, $in) or die "Could not open IN: $in\n";

while (<IN>){
    chomp;
    if (/^\@([a-z]+_[0-9]+)/){
	$indcov{$1}++;
	$allcov++;
	print "working \n";
    }
}

#open (OUT, "> coverage.txt") or die;

foreach $ind (sort keys %indcov){
    print "$ind = $indcov{$ind} sequences\n";
}

print "Total number of reads: $allcov\n";
