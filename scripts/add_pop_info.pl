 #!/usr/bin/perl

## adds name ids for plotting

use warnings;

$in= shift (@ARGV);
open (IN, $in) or die;
open (OUT, "> names_$in") or die "crap\n";

while (<IN>){
    chomp;
    /([a-z])([a-z])([a-z])/;
    print OUT "$2$3 $_\n";

}

