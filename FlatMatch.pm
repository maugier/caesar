package FlatMatch;

sub new {
    bless {};
}

sub match {

    my $p = 1;
    $p /= 26 for @{$_[1]};
    return $p;

}

1;
