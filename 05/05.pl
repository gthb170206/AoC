#!/usr/bin/perl

use strict;
use warnings;

# Rows and seats
#
# @rows = ( 0 .. 127 );
# @cols = ( 0 .. 8 );

# Rules
#
# rows: F = lower half; B = upper half
# cols: L = lower half; R = upper half
# id: row * 8 + col

# Examples
# 
# FBFBBFFRLR: row 44, column 5, seat ID 357.
# BFFFBBFRRR: row 70, column 7, seat ID 567.
# FFFBBBFRRR: row 14, column 7, seat ID 119.
# BBFFBBFRLL: row 102, column 4, seat ID 820.

my $id = 0;
my $row = 0;
my $col = 0;
my($c, $i, $m) = ("", 0, 0);
my(@r, @c, @p);

open DATA, "data" or die;
my @pass = ( <DATA> );
close DATA;
chomp @pass;

foreach ( @pass ) {
  @r = ( 0 .. 127 );
  @c = ( 0 .. 7 );
  @p = split(//);
  while ( $c = shift @p ) {
    @r = @r[0 .. scalar(@r)/2-1] if ( $c eq "F" );
    @r = @r[scalar(@r)/2 .. $#r] if ( $c eq "B" );
    @c = @c[0 .. scalar(@c)/2-1] if ( $c eq "L" );
    @c = @c[scalar(@c)/2 .. $#c] if ( $c eq "R" );
  }
  $i = $r[0] * 8 + $c[0];
  $m = $i if ( $i > $m );
  print "$_: row $r[0], col $c[0], seat ID $i.\n";
}
print "Max seat ID: $m\n";
