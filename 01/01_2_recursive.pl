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
  while ( $b = shift(@a) ) {
    foreach ( @a ) {
      if ( $a + $b + $_ == 2020 ) {
        print "$a + $b + $_ = ", $a + $b + $_, "\n";
        print "$a * $b * $_ = ", $a * $b * $_, "\n";
        last;
      }
    }
  }
}
