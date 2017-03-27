#!/usr/bin/perl

# 8xi14 CCN this script makes an ID file for BWA from the barcoseKey file

# USAGE: perl IDfileMaker.pl barcodeKey.txt

$keyfile = shift @ARGV;


open (KEY, $keyfile) or die "Could not open KEY\n";
open (OUT, "> IDfile_$keyfile") or die "Could not write\n";
while (<KEY>){
    chomp;
    if (/^[0-9]+,[A-Z]+,([a-z]+\_[0-9]+)/){
	print OUT "$1\n";
    }
else{
next;
}
  }

close (KEY);
close (OUT);
