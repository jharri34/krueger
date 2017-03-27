#!/usr/bin/perl

# 9x14  this script replaces the clumsy way we made the interleaved reference and then split it
# with split_ref.pl. This takes the pruned_.fas file from the Ref-to-Ref assembly and replaces
# @Contig_1 84bases with >scaffold_1, keeps the sequence and ditches the other junk

# USAGE: perl scaffolder.pl pruned_.fas

$fasfile = shift @ARGV;


open (FAS, $fasfile) or die "Could not open FAS\n";
open (OUT, "> scaffs_$fasfile") or die "Could not write\n";
while (<FAS>){
    chomp;
    if (/^\@Contig([0-9]+)/){
	print OUT ">scaffold_$1\n";
    }
elsif (/^[ATGCN]+/){
print OUT "$_\n";
	}
else{
next;
}
  }

close (FAS);
close (OUT);
