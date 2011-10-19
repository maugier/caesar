
package Markov;

my $begin = "__BEGIN__";
my $end = "__END__";

sub new {

    bless { state => 'learning', data => {} };

}

sub learn {

    my ($this, $tokens) = @_;
    die "Incorrect state $this->{state}" unless $this->{state} eq 'learning';

    unshift @$tokens, $begin;
    push @$tokens, $end;

    while (@$tokens > 1) {
        $this->{data}{$tokens->[0]}{$tokens->[1]}++;
        shift @$tokens;
    }

}

sub commit {

    my $this = shift;
    die "Incorrect state $this->{state}" unless $this->{state} eq 'learning';

    for my $oc (values %{$this->{data}}) {
        my $sum = 0;
        $sum += $_ for values %$oc;
        $_ /= $sum for values %$oc;
    }

    $this->{state} = 'matching';
    
}

sub match {

    my ($this, $tokens) = @_;
    die "Incorrect state $this->{state}" unless $this->{state} eq 'matching';

    unshift @$tokens, $begin;
    push @$tokens, $end;

    my $p = 1;

    while (@$tokens > 2) {
        $p *= $this->{data}{$tokens->[0]}{$tokens->[1]};
        shift @$tokens;
    }

    return $p;

}

1;
