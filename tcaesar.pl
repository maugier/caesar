#!/usr/bin/perl

use Data::Dumper;
use Markov;
use Storable;
use Term::ANSIColor;

my %names;

open NAMES, '<names/fr/all'
    or die "Can't read names: $!\n";

while(<NAMES>) {
    chomp;
    $names{uc $_}=1;
}
close NAMES;

my $matcher = retrieve('names/fr/all.pl');

sub is_valid {
    my $char = shift;
    return (ord $char >= ord 'A' && ord $char <= ord 'Z');
}

sub safelog {
    my $n = shift;
    return log $n if ($n > 0);
    return -50;
        
}

sub caesar {
	my ($shift, $str) = @_;
	my @r;
	for (split  //, uc $str) {

        if (is_valid($_)) {
    		push @r, chr (65 + (((ord $_) - 65 + $shift) % 26));
        } else {
            push @r, $_;
        }
	}
	return (join "",@r);
}

print colored(['bold white'], `figlet <<< caesar`);

print STDERR colored(['bold white'],"Entrez le nom: ");
my $name = uc <>;

chomp $name;

my @answ = map { caesar($_,$name) } (0 .. 25);

print STDERR colored(['bold white'], "Possibilités:\n");

print "$_\n" for @answ;

<>;
my %answ;

# stat match
for (@answ) {
    my $sum = 0;
    for (split /[^A-Z]+/, uc) {
        print STDERR "Testing [$_] Sum = $sum\n";
        $sum += safelog($matcher->match([split //, lc]));
    }
    $answ{$_} = [0, $sum];
}

# known names
for (@answ) {
    $answ{$_} = [1,0] if $names{$_};
}

sub tuplecmp {
    my ($x,$y) = @_;
    $x->[0] <=> $y->[0] || $x->[1] <=> $y->[1];
}

print "$_, $answ{$_}->[0], $answ{$_}->[1]\n" for sort { tuplecmp($answ{$b},$answ{$a}); } @answ;
