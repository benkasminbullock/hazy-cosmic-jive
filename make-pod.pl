#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use utf8;
use FindBin '$Bin';
use Perl::Build qw/get_commit get_info/;
use Perl::Build::Pod ':all';
use Deploy qw/do_system older/;
use Getopt::Long;
use Date::Calc 'Today';
my $ok = GetOptions (
    'force' => \my $force,
    'verbose' => \my $verbose,
);
if (! $ok) {
    usage ();
    exit;
}
my %pbv = (base => $Bin);
my $info = get_info (%pbv);
my $commit = get_commit (%pbv);
# Names of the input and output files containing the documentation.

my $pod = 'Jive.pod';
my $input = "$Bin/lib/Hazy/Cosmic/$pod.tmpl";
my $output = "$Bin/lib/Hazy/Cosmic/$pod";

my ($year, undef, undef) = Today ();

# Template toolkit variable holder

my %vars = (
    info => $info,
    commit => $commit,
    this_year => $year,
);

my $tt = Template->new (
    ABSOLUTE => 1,
    INCLUDE_PATH => [
	$Bin,
	pbtmpl (),
	"$Bin/examples",
    ],
    ENCODING => 'UTF8',
    FILTERS => {
        xtidy => [
            \& xtidy,
            0,
        ],
    },
    STRICT => 1,
);

$tt->process ($input, \%vars, $output, binmode => 'utf8')
    or die '' . $tt->error ();

exit;

sub usage
{
print <<EOF;
--verbose
--force
EOF
}
