#!/usr/bin/perl

# 29xii14 CCN this script makes an ID file for ENTROPY from the BWA ID file (and keeps things in order)
# 4i14 CCN modified to also make the "header_ids.txt" file needed for making the matrix of genotype likelihoods in R

# USAGE: perl entropy_IDfileMaker2.pl IDfile_barcodeKey.txt

$keyfile = shift @ARGV;


open (KEY, $keyfile) or die "Could not open KEY\n";
open (OUT, "> entropy_$keyfile") or die "Could not write\n";
open (OUT2, ">header_ids.txt") or die "Could not open header\n";
while (<KEY>){
    chomp;
    if (/^([a-z]+)\_([0-9]+)/){
      print OUT "aln$1\_$2 ";
      	print OUT2 "$1\_$2 ";
    }
else{
next;
}
  }
print OUT "\n";
print OUT2 "\n";
close(KEY);
open (KEY, $keyfile) or die "Could not open KEY\n";
while (<KEY>){
    chomp;
    if (/^([a-z]+)\_([0-9]+)/){
      print OUT "$1 ";
    }
else{
next;
}
  }
close (KEY);
close (OUT);
