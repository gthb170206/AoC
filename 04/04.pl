#!/usr/bin/perl

use strict;
use warnings;

# Rules
# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID) - optional

my $val = 0;
my $cnt = 0;
my @fld = qw(byr iyr eyr hgt hcl ecl pid);
my %fld;

open DATA, "data" or die;
while ( <DATA> ) {
  chomp;
  if ( (/^\s*$/ || eof(DATA)) && scalar(keys %fld) >= 0 ) {
    $cnt++;
    my $v = 1;
    foreach ( @fld ) {
      unless ( exists $fld{$_} ) {
        #print STDERR "Missing $_ on line $.\n";
        $v = 0;
        last;
      }
    }
    $val += $v;
    %fld = ();
  }
  while ( /([a-z]{3}):(\S+)/go ) {
    $fld{$1} = $2;
  }
}
close DATA;
print "Found $val valid passports (of $cnt)\n";
