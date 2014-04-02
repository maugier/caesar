package Stat;

sub new { bless [@_]; }


sub avg { 
	my $self = shift;
	return 0 if @$self == 0;
	my $sum = 0;
	$sum += $_ for @$self;
	return $sum / @$self;
}

sub std {

	my ($self,$avg) = @_;
	$avg = $self->avg() unless defined $avg;
	my $var;
	for (@$self) {
		my $e = $_ - $avg;
		$var += $e*$e;
	}
	return sqrt $var;
}

sub norm {
	my $self = shift;
	my $avg = $self->avg();
	my $std = $self->std($avg);
	return sub { return ($_[0] - $avg)/$std };
}
1;
