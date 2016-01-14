#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use utf8;
use FindBin '$Bin';
use JSON::Parse 'json_file_to_perl';
use C::Utility ':all';
use C::Template;
my $p = json_file_to_perl ('bcd.json');
my @data;
for my $k (@$p) {
    if (ref $k eq 'HASH') {
#	print $k->{pow2}, "\n";
	push @data, $k;
	for my $field (qw/upper lower/) {
	    if (length ($k->{$field}) != 10) {
		die "Bad length $k->{$field} in $k->{pow2}";
	    }
	}
	if ($k->{upper} =~ /0x0/) {
	    die "Bad leading zero $k->{upper} in $k->{pow2}";
	}
    }
}
#my $tt = Template->new (
#    INCLUDE_PATH => '.',
#    ABSOLUTE => 1,
#    STRICT => 1,
#    ENCODING => 'utf8',
#);
my $tt = C::Template->new ();
my %vars;
$vars{bcddata} = \@data;
if (-f 'bcd.c') {
    chmod 0644, 'bcd.c';
}
$tt->process ('bcd-c.tmpl', \%vars, 'bcd.c');
chmod 0444, 'bcd.c';
