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
my($c, $i) = ("", 0);
my($lr, $hr, $hi) = (127, 0, 0);
my(@r, @c, @p);
my(%r, %s);

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
  $r{$r[0]}++;
  $i = $r[0] * 8 + $c[0];
  $s{$i}++;
  $hi = $i if ( $i > $hi );
  $lr = $r[0] if ( $r[0] < $lr );
  $hr = $r[0] if ( $r[0] > $hr );
  print "$_: row $r[0], col $c[0], seat ID $i.\n";
}
print "Max seat ID: $hi\n";
print "Min row ID: $lr\n";
print "Max row ID: $hr\n";

#print "Rows: ", join(", ", sort { $a <=> $b } keys %r), "\n";
foreach ( sort { $a <=> $b } keys %r ) {
  next if ( $_ == $lr );
  last if ( $_ == $hr );
  next if ( $r{$_} == 8 );
  print "Only $r{$_} seats taken on row $_\n";
}

foreach ( ($lr + 1) * 8 + 1 .. ($hr - 1) * 8 - 1 ) {
  next if ( exists($s{$_}) );
  print "Your seat: $_ (row ", int($_ / 8), ", col ", $_ % 8, ")\n" if ( exists($s{$_ - 1}) && exists($s{$_ + 1}) );
}
