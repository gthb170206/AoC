#!/usr/bin/perl

use strict;
use warnings;

my $cnt = 0;
my $grp = 0;
my $mem = 0;
my %ans;

open DATA, "data" or die;
while ( <DATA> ) {
  chomp;
  if ( (/^\s*$/ || eof(DATA)) && scalar(keys %ans) >= 0 ) {
    $grp++;
    #print STDERR "Answers from group $grp ($mem members):\n";
    foreach ( sort { $a cmp $b } keys %ans ) {
      #print STDERR " * $_: ", $ans{$_}, ($ans{$_} == $mem) ? " TRUE" : "", "\n";
      $cnt++ if ( $ans{$_} == $mem );
    }
    %ans = ();
    $mem = 0;
    #print STDERR "\n";
  } else {
    foreach ( split(//) ) {
      $ans{$_}++;
    }
    $mem++;
  }
}
close DATA;
print "Found $cnt questions answered with \"yes\" by everyone in their group\n";
