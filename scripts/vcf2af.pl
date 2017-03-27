#!/usr/bin/perl


#use strict;
#use warnings;

# print out allele frequency estimates output by bcftools view
#
# USAGE: perl vcf2af.pl in.vcf
#


my $nloc = 0;


my $in = shift (@ARGV);
open (IN, $in) or die "Could not read the vcf file\n";
my $out = $in;
if ($out =~ s/vcf/af/){
	open (OUT, "> $out") or die "Could not write $out\n";
}
else {
	exit "File extension was not vcf\n";
}

while (<IN>){
    chomp;
    ## read genetic data lines
    if ((m/^scaffold_(\d+)\s+(\d+)/) && (!m/[AGCT],[AGCT]/)){
	print OUT "$1 $1".":"."$2 ";
	#print OUT "$1 $2 ";
	if((m/;AF1=([\d.e-]+);/)){ ## number, including 1 or scientific
	    print OUT "$1";
	}
	print OUT "\n";
	$nloc++;
    }
}


close (IN);
close (OUT);
print "Number of loci: $nloc\n";

