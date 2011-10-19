#!/usr/bin/perl

use Storable;
use Data::Dumper;

print Dumper(retrieve($_)) for @ARGV;
