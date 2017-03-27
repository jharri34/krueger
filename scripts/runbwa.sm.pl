#!/usr/bin/perl

## run bwa aln and samse on fastq files passed from the commandline

## USAGE: perl runbwa.pl *fastq

use warnings;

foreach $fastq (@ARGV){
	$fastq =~ m/(\w+_\d+)/;
	$id = $1;
	print "Mapping reads for $id\n";
	system "bwa aln -n 6 -l 20 -k 2 -t 20 -R 20 -q 10 -f aln"."$id".".sai hapassembly_ref $fastq\n";
	system "bwa samse -n 1 -r \'\@RG\tID:updown"."$id"."\tSM:updown"."$id"."\' -f aln"."$id".".sam hapassembly_ref aln"."$id".".sai $fastq\n";
}
