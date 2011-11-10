#!/usr/bin/perl

use Data::Dumper;
use Term::ANSIColor;
use Caesar;
use Stat;

my $caesar = Caesar->new();

print colored(['bold cyan'], `figlet <<< caesar`);

print STDERR colored(['bold white'],"Entrez une phrase: ");
my $name = uc <>;

my @break = $caesar->break($name);
my $normer = Stat->new(map {$_->[2][1]} @break)->norm;

for (@break) {
	my $str = sprintf " %02d | % 8f | %s", $_->[0], $_->[2][1], $_->[1];
	my $color = 'red';
	$color = 'bold yellow' if $normer->($_->[2][1]) > 0.15;
	$color = 'bold green' if $_->[2][0];
	print colored([$color], $str);
}


