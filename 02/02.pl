#!/usr/bin/perl

use strict;
use warnings;

my @arr;
my $tot = 0;

sub check_arr(@);

open DATA, "data" or die;
@arr = <DATA>;
close DATA;
chomp @arr;

foreach ( @arr ) {
  /^(\d+)-(\d+) +(\w): (\w+)$/;
  my $min = $1;
  my $max = $2;
  my $chr = $3;
  my $str = $4;
  my $cnt = eval "\"$str \"=~ tr/$chr/$chr/";
  if ( defined($cnt) && $cnt >= $min && $cnt <= $max ) {
    $tot++;
    #print "Valid password: $str ($min <= $cnt <= $max instances of $chr)\n";
  }
}
print "$tot passwords valid\n";
