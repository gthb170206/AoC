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
  next if ( length($str) < $max );
  my @arr = ( "", split(//, $str) );
  $tot++ if ( $arr[$min] eq $chr xor $arr[$max] eq $chr );
}
print "$tot valid passwords found\n";
