#!/usr/bin/perl

use strict;
use warnings;

my @arr;

open DATA, "data" or die;
@arr = <DATA>;
close DATA;
chomp @arr;

while ( my $a = shift @arr ) {
  foreach ( @arr ) {
    if ( $a + $_ == 2020 ) {
      print $a, " + ", $_, " = ", $a + $_, " (", scalar(@arr), ")\n";
      print $a, " * ", $_, " = ", $a * $_, " (", scalar(@arr), ")\n";
      exit(0);
    }
  }
}
