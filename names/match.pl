#!/usr/bin/perl

use Markov;
use FlatMatch;
use Storable;

my %matchers;

$matchers{flat} = FlatMatch->new();

for (@ARGV) {
    $matchers{$_} = retrieve($_);
    print STDERR "Matcher '$_' loaded...\n";
}


while(<STDIN>) {
    chomp;
    my %result;
    my $list = [split //, lc];
    $result{$_} = $matchers{$_}->match($list) for keys %matchers;
    print "$_:";
    print "$_=$result{$_};" for sort { $result{$b} <=> $result{$a} } keys %result;
    print "\n";
}
