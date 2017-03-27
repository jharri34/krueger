#!/usr/bin/perl
#### 5ix15 CCN modifications to make this work with our files
## Individuals are in sets of three columns in mpgl

use warnings;

unless (scalar @ARGV == 2){
    die "Usage: select_loci_mpgl_CCN.pl subdetList.txt(from R) variants.mpgl";
}

### get indexes for loci to retain
open(LOCI, "$ARGV[0]") or die "Could not open index file";
$nloci = 0;
while(<LOCI>){
    chomp;
    $nloci++;
    $retain{$_} = 1;
}
close(LOCI);


open(MPGL, "$ARGV[1]") or die "Could not open mpgl file";
if(defined($firstline = <MPGL>)){
    chomp $firstline;
    $firstline =~ s/\d+$/$nloci/;   
}

$basename = $ARGV[1];
$basename =~ s/\.mpgl//;
## open output files for mpgl split into populations
open OUTFILE, ">", "$basename"."_focalloci.mpgl" or 
  die "Could not open a file to write to for $basename";

$locus=1;
while(<MPGL>){
    $locus++;
    if(exists $retain{$locus}){
      print OUTFILE $_;
      print "$locus \n";
    }
}
close(OUTFILE);
close(MPGL);
