#!/usr/bin/perl
#17i16 modified to change spartina ind IDs to lower case
#8vii15 script to convert a barcodeKey with lowercase barcodes to uppercase

# USAGE: perl  barcodeUPPERCASE.pl standardBarcodeKey.csv

$key = shift @ARGV;


open (IN, $key) or die "Could not open IN\n";
open (OUT, "> lc_$key") or die "Could not write\n";
while (<IN>){
    chomp;
    if (/^barcode/){
      print OUT "$_\n";      
    }
    elsif (/^([0-9]+),([A-Z]+),([A-Z]+)(\_[0-9]+)/){
	$a = lc $3;
	   print OUT "$1,$2,$a$4\n";
	 }
      }
close (IN);
close (OUT);

