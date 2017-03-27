#!/usr/bin/perl
#
# This script is a wrapper around samtools for batch conversion, sorting and indexing of sam file. This version uses fork to split the job over mutliple processors. Adjust $ncpu for the desired number of cpus. 
#
# Usage: perl sam2bam.pl *sam
#
use warnings;

my $ncpu = 16;
my $ctr = 0;
my $nfiles = @ARGV; 
print "Analyzing $nfiles files\n";
$cnt_part = int ($nfiles/$ncpu);
		
for $ctr (0..($ncpu-1)){## control the number of parallel jobs
	$pid = fork(); ## generate child process
	if($pid){ ## parent becasue fork returned non-zero
		push (@childs, $pid);
	}
	elsif($pid == 0){ ## this is a child
		## split array of files
		$cnt_start = $ctr * ($cnt_part+1);
		if ($ctr == ($ncpu-1)){
			$cnt_end = ($nfiles-1);
		}
		else {
			$cnt_end = $cnt_start + $cnt_part;
		}
                @childsfiles = @ARGV[$cnt_start..$cnt_end];
		foreach $sam (@childsfiles){
			$base = $sam;
			$base =~ s/sam//;
			print "Compressing, sorting and indexing $base\n";
			system "samtools view -b -S -o $base"."bam $sam\n";
			system "samtools sort $base"."bam $base"."sorted\n";
			system "samtools sort $base"."bam -o $base"."sorted.bam\n";
		}
		exit; # end of child job
	}	
}
foreach (@childs){
	waitpid($_, 0);
}
