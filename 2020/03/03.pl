#!/usr/bin/perl

use strict;
use warnings;

my ($x, $y) = (0, 0);
my @arr;

open DATA, "data" or die;
@arr = <DATA>;
close DATA;
chomp @arr;

my $d = length($arr[0]);
my $s = ( substr($arr[$y], $x, 1) eq "#" ) ? 1 : 0;
my $m = 0;

while ( ++$y <= $#arr ) {
  $m++;
  $x += 3;
  $x %= $d;
  $s++ if ( substr($arr[$y], $x, 1) eq "#" );
}
print "We hit $s trees in $m moves\n";
