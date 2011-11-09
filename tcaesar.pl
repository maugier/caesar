#!/usr/bin/perl

use Data::Dumper;
use Term::ANSIColor;
use Caesar;

my $caesar = Caesar->new();

print colored(['bold white'], `figlet <<< caesar`);

print STDERR colored(['bold white'],"Entrez le nom: ");
my $name = uc <>;

print Dumper([ $caesar->break($name) ]);


