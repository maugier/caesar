#!/usr/bin/perl

my %names;

open NAMES, '<names/fr/all'
    or die "Can't read names: $!\n";

while(<NAMES>) {
    $names{$_}=1;
}
close NAMES;

sub caesar {
	my ($shift, $str) = @_;
	my @r;
	for (split  //,$str) {
		push @r, chr (65 + (((ord $_) - 65 + $shift) % 26));
	}
	return (join "",@r);
}

sub tuplecmp {
    $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1];
}

print STDERR "Entrez le nom: ";
my $name = uc <>;

chomp $name;

my @answ = map { caesar($_,$name) } (0 .. 25);

print STDERR "Possibilités:\n"

print "$_\n" for @answ;

<>;



