#!/usr/bin/perl

use strict;
use warnings;

my @arr;
my @x = qw( 1 3 5 7 1 );
my @y = qw( 1 1 1 1 2 );
my @s;

open DATA, "data" or die;
@arr = <DATA>;
close DATA;
chomp @arr;
my $d = length($arr[0]);

foreach my $i ( 0 .. $#x ) {
  my ($m, $x, $y) = (0, 0, 0);
  my $s = ( substr($arr[$y], $x, 1) eq "#" ) ? 1 : 0;

  do {
    $m++;
    $x += $x[$i];
    $x %= $d;
    $y += $y[$i];
    $s++ if ( substr($arr[$y], $x, 1) eq "#" );
  } while ( $y <= $#arr );
  $s[$i] = $s;
  print "We hit $s trees in $m moves ($i)\n";
}
print "Hits: ", join(", ", @s), "\n";
printf "The answer is: %d\n", eval join("*", @s);
