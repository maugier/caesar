#!/usr/bin/perl

use Markov;
use Data::Dumper;

my $m = Markov->new();

while(<>) {
    chomp;
    $m->learn([split //]);
}

$m->commit;

print Dumper($m);
