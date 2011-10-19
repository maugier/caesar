#!/usr/bin/perl

while(<>) {

    m#<dd><span style="font-family:monospace;font-weight:bold;font-size:11px;cursor:help;" title="Genre&nbsp;:[^>]*>\((.)\)</span> <b><a [^>]*>(\w+)</a></b>#

        or next;
    print STDERR "$1 $2\n";
    print $m $2 if $1 eq 'm' || $1 eq 'x';
    print $f $2 if $1 eq 'f' || $1 eq 'x';

}

close $m;
close $f;
