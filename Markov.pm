
package Markov;

my $begin = "__BEGIN__";
my $end = "__END__";

sub new {

    bless { state => 'learning', data => {} };

}

sub learn {

    my ($this, $tokens) = @_;
    die "Incorrect state $this->{state}" unless $this->{state} eq 'learning';

    my @tok = @$tokens;

    unshift @tok, $begin;
    push @tok, $end;

    while (@tok > 1) {
        $this->{data}{$tok[0]}{$tok[1]}++;
        shift @tok;
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

    my @tok = @$tokens;

    unshift @tok, $begin;
    push @tok, $end;

    my $p = 1;

    while (@tok > 1) {

        $p *= $this->{data}{$tok[0]}{$tok[1]};
        shift @tok;
    }
    return $p;

}

1;
