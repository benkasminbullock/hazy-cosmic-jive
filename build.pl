#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use FindBin '$Bin';
use Perl::Build;
perl_build (
    c => [{
	dir => "$Bin/bcd",
	stems => ['bcd'],
    }],
    make_pod => "$Bin/make-pod.pl",
);
exit;
