# This is a test for module Hazy::Cosmic::Jive.

use warnings;
use strict;
use Test::More;
use Hazy::Cosmic::Jive 'float_to_string';
my $d;
    $d = 1234.5678;
    doit ($d);
    $d = 9.784536e100;
    doit ($d);
    $d = 0.008765;
    doit ($d);
    $d = 1.0;
    doit ($d);
    $d = 16.0;
    doit ($d);
    $d = 3.0;
    doit ($d);
    $d = 3.00003;
    doit ($d);

done_testing ();

sub doit
{
my ($d) = @_;
my $perl = float_to_string ($d);
my $sprintf = sprintf ("%.13e", $d);
is ($perl, $sprintf, "$d gives same result for perl and sprintf");
}

# Local variables:
# mode: perl
# End:
