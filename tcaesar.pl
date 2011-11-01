#!/usr/bin/perl


sub caesar {
	my ($shift, $str) = @_;
	my @r;
	for (split  //,$str) {
		push @r, chr (65 + (((ord $_) - 65 + $shift) % 26));
	}
	return (join "",@r);
}


print STDERR "Entrez le nom: ";
my $name = uc <>;

chomp $name;

for (0 .. 25) {
	print "Shift $_: ",caesar($_,$name),"\n";
}
