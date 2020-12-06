#!/usr/bin/perl

use strict;
use warnings;

my $cnt = 0;
my $grp = 0;
my %ans;

open DATA, "data" or die;
while ( <DATA> ) {
  chomp;
  if ( (/^\s*$/ || eof(DATA)) && scalar(keys %ans) >= 0 ) {
    $grp++;
    $cnt += scalar(keys %ans);
    %ans = ();
  } else {
    foreach ( split(//) ) {
      $ans{$_} = 1;
    }
  }
}
close DATA;
print "Found $cnt questions answered with \"yes\"\n";
