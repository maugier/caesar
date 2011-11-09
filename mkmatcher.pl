#!/usr/bin/perl

use Markov;
use Storable 'store_fd';

my $m = Markov->new();

while(<>) {
    chomp;
    $m->learn([split //, lc]);
}

$m->bias('a' .. 'z');
$m->commit;

store_fd($m, *STDOUT);

