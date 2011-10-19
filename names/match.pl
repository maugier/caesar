#!/usr/bin/perl

use Markov;
use Storable;

my %matchers;


for (@ARGV) {
    $matchers{$_} = retrieve($_);
}


while(<>) {
    my %result;
    my $list = [split //];
    $result{$_} = $matchers{$_}->match($list) for keys %matchers;
    print "$_:";
    print "$_=$result{$_};" for keys %result;
    print "\n";
}
