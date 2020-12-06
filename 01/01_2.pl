#!/usr/bin/perl

use strict;
use warnings;

my @arr;

open DATA, "data" or die;
@arr = <DATA>;
close DATA;
chomp @arr;

while ( my $a = shift(@arr) ) {
  last if ( scalar(@arr) <= 2 );
  my @a = @arr;
  while ( my $b = shift(@a) ) {
    foreach ( @a ) {
      if ( $a + $b + $_ == 2020 ) {
        print "$a + $b + $_ = ", $a + $b + $_, "\n";
        print "$a * $b * $_ = ", $a * $b * $_, "\n";
        exit(0);
      }
    }
  }
}
