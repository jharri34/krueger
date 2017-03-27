#!/usr/bin/perl

#Usage: ./sort_mpgl_loci.pl loci.txt file.mpgl

use warnings;

$loci = shift @ARGV;
$mpgl = shift @ARGV;

open(LOCI, $loci) or die "Could not open $loci\n";

my %loci=();

while(<LOCI>){
    chomp;
    $loci{$_}=1; #Dummy hash
}

close(LOCI);

open(MPGL, $mpgl) or die "Could not open $mpgl\n";

open(OUT, "> $loci$mpgl") or die "Could not open OUT\n";

while(<MPGL>){
    chomp;
    m/^scaffold_(\d+:\d+)/;
    if(exists $loci{$1}){
	print OUT "$_\n";
    }
}
