#!/usr/bin/perl

# This programs takes an ace file as input and outputs a fasta file
# with a pruned subset of contigs (consensus seqs. only). Contigs are
# pruned based on the following critiria (all gaps are also removed):

# contig length must be >= $minL and <= $maxL
# contigs cannot include the reverse sequence

# USAGE: perl pruneContigs.pl assembly.ace minL maxL

$in = shift @ARGV;

$minL = shift @ARGV;
$maxL = shift @ARGV;

open (IN, $in) or die "Could not open IN\n";
open (OUT, "> pruned_$in") or die "Could not open out\n";

while(<IN>){
    chomp;
    if (/^CO\s+(\S+)\s+(\d+)/){
	$con = $1;
	$ln = $2;
	if ($ln >= $minL && $ln <= $maxL){
	    $keep{$con} = 1;
	}
	else {
	    $keep{$con} = 0;
	}
    }
    elsif (/^AF\s+\S+\s+(\w)/){
	unless ($1 eq 'U'){
	    $keep{$con} = 0;
	}
    }
}

close (IN);
open (IN, $in) or die "Could not open IN\n";

while(<IN>){
    chomp;
    if (/^CO\s+(\S+)/){
	$con = $1;
	if ($keep{$con}==1){ # good contig
	    $read = 1;
	    @seq = ();
	    while($read == 1){
		$a = <IN>;
		chomp $a;
		if ($a =~ /[ATCGN-]/){
		    push @seq, $a;
		}
		else {
		    $read = 0;
		}
	    }
	    $seq = join "", @seq;
	    $seq =~ s/-//g;
	    print OUT "> $con\n$seq\n";
	}
    }
}
close (IN);
close (OUT);
