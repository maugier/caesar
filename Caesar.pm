#!/usr/bin/perl

package Caesar ;

use Markov;
use Storable;

sub new {

    my $self;

    open NAMES, '<names/fr/all'
        or die "Can't read names: $!\n";

    while(<NAMES>) {
        chomp;
        $self->{names}{uc $_}=1;
    }
    close NAMES;

    $self->{matcher} = retrieve('names/fr/all.pl');

    bless $self;
}

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

sub break {

    my ($self, $name) = @_;

    my @answ = map { [$_, caesar($_,$name)] } (0 .. 25);

    for (@answ) {
        my $sum = 0;
        for (split /[^A-Z]+/, uc $_->[1]) {
            $sum += safelog($self->{matcher}->match([split //, lc]));
        }
        $_->[2] = [0, $sum];
    }

# known names
    for (@answ) {
        $_->[2] = [1,0] if $self->{names}{$_->[1]};
    }

    return sort { tuplecmp($b->[2], $a->[2]) } @answ;

}

sub tuplecmp {
    my ($x,$y) = @_;
    $x->[0] <=> $y->[0] || $x->[1] <=> $y->[1];
}

1;
