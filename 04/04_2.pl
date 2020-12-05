#!/usr/bin/perl

use strict;
use warnings;

# Rules
#byr (Birth Year)	1920-2002
#iyr (Issue Year)	2010-2020
#eyr (Expiration Year)	2020-2030
#hgt (Height)		150-193cm or 59-76in
#hcl (Hair Color)	#[0-9a-f]{6}
#ecl (Eye Color)	amb blu brn gry grn hzl oth
#pid (Passport ID)	[0-9]{9}
#cid (Country ID)	ignored

my $val = 0;
my $cnt = 0;
my @fld = qw(byr iyr eyr hgt hcl ecl pid);
my %fld;
my %val = (
  "byr"	=> qr/^(?:19[2-9][0-9]|200[0-2])$/,
  "iyr"	=> qr/^(?:201[0-9]|2020)$/,
  "eyr"	=> qr/^(?:202[0-9]|2030)$/,
  "hgt"	=> qr/^(?:1[5-8][0-9]cm|19[0-3]cm|59in|6[0-9]in|7[0-6]in)$/,
  "hcl"	=> qr/^#[0-9a-f]{6}$/,
  "ecl"	=> qr/^(?:amb|blu|brn|gr[ny]|hzl|oth)$/,
  "pid"	=> qr/^[0-9]{9}$/
);

open DATA, "data" or die;
while ( <DATA> ) {
  chomp;
  if ( (/^\s*$/ || eof(DATA)) && scalar(keys %fld) >= 0 ) {
    $cnt++;
    my $v = 1;
    foreach ( @fld ) {
      unless ( exists $fld{$_} ) {
        print STDERR "missing $_ on line $. (pp #$cnt)\n";
        print STDERR "-" x 50, "\n" unless ( eof(DATA) );
        $v = 0;
        last;
      }
      unless ( $fld{$_} =~ /$val{$_}/ ) {
        print STDERR "invalid $_: $fld{$_} on line $. (pp #$cnt)\n";
        print STDERR "-" x 50, "\n" unless ( eof(DATA) );
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
