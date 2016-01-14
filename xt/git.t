use Test::More;
use File::Temp 'tempfile';
use Path::Tiny;
use FindBin '$Bin';
my $builder = Test::More->builder;
binmode $builder->output,         ":utf8";
binmode $builder->failure_output, ":utf8";
binmode $builder->todo_output,    ":utf8";
binmode STDOUT, ":encoding(utf8)";
binmode STDERR, ":encoding(utf8)";
my ($fh, $filename) = tempfile ();
close $fh or die $!;
system ("chdir $Bin;git diff > $filename");
ok (! -s $filename, "no uncommitted changes");
if (-f $filename) {
    unlink $filename or die $!;
}
system ("chdir $Bin;git branch > $filename");
my $in = path($filename)->slurp ();
like ($in, qr/\*\h*master/, "On master branch");
if (-f $filename) {
    unlink $filename or die $!;
}
done_testing ();
