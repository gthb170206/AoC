#!/usr/bin/perl

use strict;
use warnings;

my @arr;

sub check_arr(@);

open DATA, "data" or die;
@arr = <DATA>;
close DATA;
chomp @arr;

check_arr(@arr);

sub check_arr(@) {
  my $a = shift(@_);
  my @a = @_;
  check_arr(@a) if ( scalar(@a) > 2 );
  foreach ( @a ) {
    if ( $a + $_ == 2020 ) {
      print $a, " + ", $_, " = ", $a + $_, " (", scalar(@a), ")\n";
      print $a, " * ", $_, " = ", $a * $_, " (", scalar(@a), ")\n";
      last;
    }
  }
}
